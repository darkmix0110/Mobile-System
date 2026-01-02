import 'package:flutter/material.dart';
import '../models/track.dart';

class TrackItem extends StatelessWidget {
  final Track track;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TrackItem({
    super.key,
    required this.track,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(track.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error.withValues(alpha: 0.8),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(), // Виклик видалення
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          onTap: onEdit,
          leading: const CircleAvatar(child: Icon(Icons.music_note)),
          title: Text(track.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(track.artist),
          trailing: Text(track.duration),
        ),
      ),
    );
  }
}