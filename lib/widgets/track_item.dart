import 'package:flutter/material.dart';
import '../models/track.dart';

class TrackItem extends StatelessWidget {
  final Track track;
  final Function(String) onDelete;
  final VoidCallback onEdit;
  final bool isPlaying; // Додаємо стан програвання
  final VoidCallback onTogglePlay; // Функція для кнопки play

  const TrackItem({
    super.key,
    required this.track,
    required this.onDelete,
    required this.onEdit,
    required this.isPlaying,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Dismissible забезпечує видалення свайпом 
    return Dismissible(
      key: ValueKey(track.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => onDelete(track.id),
      // 2. InkWell дозволяє редагувати при натисканні на весь рядок [cite: 110]
      child: InkWell(
        onTap: onEdit,
        child: Card(
          child: ListTile(
            // Повертаємо кнопку PLAY зліва
            leading: IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                color: isPlaying ? Colors.red : Colors.green,
              ),
              onPressed: onTogglePlay,
            ),
            title: Text(track.title),
            subtitle: Text('${track.artist} • ${track.duration}'),
            // Іконка для підказки, що можна редагувати
            trailing: const Icon(Icons.edit, size: 16, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}