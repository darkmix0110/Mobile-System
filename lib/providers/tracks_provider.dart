import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/track.dart';

class TracksNotifier extends StateNotifier<List<Track>> {
  // Передаємо порожній список [] у конструктор базового класу StateNotifier
  TracksNotifier() : super([
    Track(id: 't1', title: 'Espresso', artist: 'Sabrina Carpenter', duration: '2:55', genreId: 'g1'),
    Track(id: 't2', title: 'Bohemian Rhapsody', artist: 'Queen', duration: '5:55', genreId: 'g2'),
    Track(id: 't3', title: 'Take Five', artist: 'Dave Brubeck', duration: '5:24', genreId: 'g3'),
    Track(id: 't4', title: 'Not Like Us', artist: 'Kendrick Lamar', duration: '4:34', genreId: 'g4'),
  ]);

  // Додавання треку
  void addTrack(Track t) {
    state = [...state, t];
  }

  // Редагування треку
  void editTrack(Track updatedTrack) {
    state = [
      for (final t in state)
        if (t.id == updatedTrack.id) updatedTrack else t
    ];
  }

  // Видалення треку
  void removeTrack(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  // Вставлення треку (для Undo)
  void insertTrack(int index, Track t) {
    final newList = [...state];
    newList.insert(index, t);
    state = newList;
  }
}

// Створюємо провайдер, який буде доступний у всьому додатку
final tracksNotifierProvider = StateNotifierProvider<TracksNotifier, List<Track>>((ref) {
  return TracksNotifier();
});

// Провайдер для збереження ID треку, який зараз "грає"
final playingTrackIdProvider = StateProvider<String?>((ref) => null);