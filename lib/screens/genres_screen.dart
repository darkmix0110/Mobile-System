import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/genres_provider.dart';
import '../providers/tracks_provider.dart';
import '../widgets/genre_item.dart';
import 'tracks_screen.dart';

class GenresScreen extends ConsumerWidget {
  const GenresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Підписуємося на провайдери
    final genres = ref.watch(genresProvider);
    final tracks = ref.watch(tracksNotifierProvider);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,           // Дві колонки згідно з ЛР
        childAspectRatio: 3 / 2,     // Співвідношення сторін карток
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: genres.length,
      itemBuilder: (ctx, i) {
        // Рахуємо кількість треків для цього жанру в реальному часі
        final count = tracks.where((t) => t.genreId == genres[i].id).length;

        return GenreItem(
          genre: genres[i],
          trackCount: count,
          onSelect: () {
            // Навігація до відфільтрованого списку треків
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => Scaffold(
                  appBar: AppBar(title: Text(genres[i].name)),
                  body: TracksScreen(filterGenreId: genres[i].id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}