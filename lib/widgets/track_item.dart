import 'package:flutter/material.dart';
import '../models/track.dart';

class TrackItem extends StatelessWidget {
  final Track track;
  final bool isPlaying; // Чи є цей трек активним
  final VoidCallback onPlayTap; // Функція, що викличеться при натисканні

  const TrackItem({
    super.key,
    required this.track,
    required this.isPlaying,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      // Змінюємо колір фону, якщо трек грає
      color: isPlaying ? Colors.indigo.shade50 : Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isPlaying ? Colors.green : Colors.indigo,
          child: const Icon(Icons.music_note, color: Colors.white),
        ),
        title: Text(track.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${track.artist} • ${track.duration}'),
        trailing: IconButton(
          // Умова варіанта №9: зміна іконки залежно від стану [cite: 38, 52]
          icon: Icon(
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
            color: isPlaying ? Colors.red : Colors.green,
            size: 35,
          ),
          onPressed: onPlayTap,
        ),
      ),
    );
  }
}