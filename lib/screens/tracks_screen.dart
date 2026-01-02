import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/track.dart';
import '../providers/tracks_provider.dart';
import '../widgets/track_item.dart';
import '../widgets/new_track.dart';
import '../main.dart';

class TracksScreen extends ConsumerStatefulWidget {
  final String? filterGenreId;
  const TracksScreen({super.key, this.filterGenreId});

  @override
  ConsumerState<TracksScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends ConsumerState<TracksScreen> {
  @override
  void initState() {
    super.initState();
    // Завантажуємо дані при вході на екран [cite: 8, 26]
    Future.microtask(() => 
      ref.read(tracksNotifierProvider.notifier).fetchTracks().catchError((error) {
        messengerKey.currentState?.showSnackBar(
          const SnackBar(content: Text('Помилка завантаження даних!')) // [cite: 11]
        );
      })
    );
  }

  void _showForm(Track? track) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => NewTrack(existingTrack: track, initialGenreId: widget.filterGenreId),
    );

    if (result == null) return;

    final notifier = ref.read(tracksNotifierProvider.notifier);
    final trackData = Track(
      id: track?.id ?? '',
      title: result['title']!,
      artist: result['artist']!,
      duration: result['duration']!,
      genreId: result['genreId']!,
    );

    try {
      if (track == null) {
        await notifier.addTrack(trackData);
      } else {
        await notifier.editTrack(trackData);
      }
    } catch (e) {
      messengerKey.currentState?.showSnackBar(const SnackBar(content: Text('Помилка збереження!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final allTracks = ref.watch(tracksNotifierProvider);
    final tracks = widget.filterGenreId == null 
        ? allTracks 
        : allTracks.where((t) => t.genreId == widget.filterGenreId).toList();

    // Показуємо індикатор загрузки [cite: 9, 30, 31]
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: tracks.isEmpty 
        ? const Center(child: Text('Немає треків у базі.'))
        : ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (ctx, i) {
              final track = tracks[i];
              return TrackItem(
                track: track,
                onEdit: () => _showForm(track),
                onDelete: () {
                  final index = allTracks.indexOf(track);
                  final notifier = ref.read(tracksNotifierProvider.notifier);
                  
                  // Очищуємо попередні повідомлення, щоб нове з'явилося миттєво
                  messengerKey.currentState?.clearSnackBars(); 

                  // Видаляємо трек локально (миттєвий відгук в UI) [cite: 45]
                  notifier.removeTrackLocal(track.id);
                  
                  messengerKey.currentState?.showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 3), // Час, який повідомлення буде на екрані 
                      content: Text('Видалено "${track.title}"'),
                      action: SnackBarAction(
                        label: 'Undo', // [cite: 52]
                        onPressed: () {
                          // Якщо натиснули Undo — повертаємо трек у список [cite: 54]
                          notifier.insertTrackLocal(index, track);
                        },
                      ),
                    ),
                  ).closed.then((reason) {
                    // Код нижче виконається автоматично через 3 секунди, 
                    // ЯКЩО користувач не натиснув кнопку Undo [cite: 36, 57]
                    if (reason != SnackBarClosedReason.action) {
                      // Тільки тепер робимо реальний запит на видалення з бази [cite: 40, 59]
                      notifier.deleteTrackFromDb(track.id).catchError((error) {
                        messengerKey.currentState?.showSnackBar(
                          const SnackBar(content: Text('Помилка видалення з сервера!'))
                        );
                      });
                    }
                  });
                },
              );
            },
          ),
      floatingActionButton: widget.filterGenreId == null ? FloatingActionButton(
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}