import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import '../models/track.dart';

// Окремий провайдер для стану завантаження [cite: 9]
final isLoadingProvider = StateProvider<bool>((ref) => false);

class TracksNotifier extends StateNotifier<List<Track>> {
  TracksNotifier(this.ref) : super([]);
  final Ref ref;

  // ЗАМІНІТЬ ЦЕ ПОСИЛАННЯ НА ВАШЕ З FIREBASE CONSOLE 
  final String _baseUrl = 'https://musicapp-69bca-default-rtdb.firebaseio.com/';

  // Отримання даних (GET) [cite: 8, 26]
  Future<void> fetchTracks() async {
    ref.read(isLoadingProvider.notifier).state = true; // Включаємо індикатор [cite: 29]
    try {
      final response = await http.get(Uri.parse('$_baseUrl.json'));
      if (response.body == 'null') {
        state = [];
        return;
      }
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Track> loadedTracks = [];
      data.forEach((id, item) {
        loadedTracks.add(Track.fromJson(id, item));
      });
      state = loadedTracks;
    } catch (error) {
      rethrow; // Передаємо помилку в UI [cite: 11]
    } finally {
      ref.read(isLoadingProvider.notifier).state = false; // Вимикаємо індикатор
    }
  }

  // Додавання (POST) [cite: 8, 26]
  Future<void> addTrack(Track track) async {
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: json.encode(track.toJson()),
    );
    final id = json.decode(response.body)['name'];
    final newTrack = Track(
      id: id,
      title: track.title,
      artist: track.artist,
      duration: track.duration,
      genreId: track.genreId,
    );
    state = [...state, newTrack];
  }

  // Редагування (PUT) [cite: 8, 26]
  Future<void> editTrack(Track updatedTrack) async {
    await http.put(
      Uri.parse('$_baseUrl/${updatedTrack.id}.json'),
      body: json.encode(updatedTrack.toJson()),
    );
    state = [
      for (final t in state)
        if (t.id == updatedTrack.id) updatedTrack else t
    ];
  }

  // Локальні методи для роботи Undo (без запитів до БД) [cite: 10, 35]
  void removeTrackLocal(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  void insertTrackLocal(int index, Track track) {
    final newList = [...state];
    newList.insert(index, track);
    state = newList;
  }

  // Видалення з бази (DELETE) [cite: 8, 59]
  Future<void> deleteTrackFromDb(String id) async {
    await http.delete(Uri.parse('$_baseUrl/$id.json'));
  }
}

final tracksNotifierProvider = StateNotifierProvider<TracksNotifier, List<Track>>((ref) {
  return TracksNotifier(ref);
});