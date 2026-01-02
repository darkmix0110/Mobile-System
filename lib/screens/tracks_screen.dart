import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/track.dart';
import '../providers/tracks_provider.dart';
import '../widgets/track_item.dart';
import '../widgets/new_track.dart';
import '../main.dart'; // Для messengerKey

class TracksScreen extends ConsumerWidget {
  final String? filterGenreId;
  const TracksScreen({super.key, this.filterGenreId});

  void _showForm(BuildContext context, WidgetRef ref, {Track? track}) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => NewTrack(existingTrack: track, initialGenreId: filterGenreId),
    );

    if (result == null) return;

    final notifier = ref.read(tracksNotifierProvider.notifier);
    final trackData = Track(
      id: track?.id ?? DateTime.now().toString(),
      title: result['title']!,
      artist: result['artist']!,
      duration: result['duration']!,
      genreId: result['genreId']!,
    );

    if (track == null) {
      notifier.addTrack(trackData);
    } else {
      notifier.editTrack(trackData);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTracks = ref.watch(tracksNotifierProvider);
    final tracks = filterGenreId == null 
        ? allTracks 
        : allTracks.where((t) => t.genreId == filterGenreId).toList();

    return Scaffold(
      body: tracks.isEmpty 
        ? const Center(child: Text('Список порожній. Додайте перший трек!'))
        : ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (ctx, i) {
              final track = tracks[i];
              return TrackItem(
                track: track,
                onEdit: () => _showForm(context, ref, track: track),
                onDelete: () {
                  final index = allTracks.indexOf(track);
                  
                  // 1. ЗАХОПЛЮЄМО нотіфайєр у змінну ЗАЗДАЛЕГІДЬ
                  final notifier = ref.read(tracksNotifierProvider.notifier);
                  
                  // 2. Видаляємо трек
                  notifier.removeTrack(track.id);
                  
                  messengerKey.currentState?.clearSnackBars();
                  messengerKey.currentState?.showSnackBar(SnackBar(
                    content: Text('Видалено "${track.title}"'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        // 3. Використовуємо захоплений notifier замість ref.read
                        // Тепер це спрацює, навіть якщо ви перейшли на вкладку Жанри!
                        notifier.insertTrack(index, track);
                      },
                    ),
                  ));
                },
              );
            },
          ),
      floatingActionButton: filterGenreId == null ? FloatingActionButton(
        onPressed: () => _showForm(context, ref),
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}