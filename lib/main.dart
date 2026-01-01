import 'package:flutter/material.dart';

// 1. Додано 'const' до конструктора моделі даних
class Track {
  final String title;
  final String artist;
  final String duration;

  const Track({
    required this.title,
    required this.artist,
    required this.duration,
  });
}

void main() {
  runApp(const MyMusicApp());
}

class MyMusicApp extends StatelessWidget {
  const MyMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TrackListScreen(),
    );
  }
}

class TrackListScreen extends StatelessWidget {
  const TrackListScreen({super.key});

  // Тепер список констант працюватиме коректно
  final List<Track> tracks = const [
    Track(title: 'In the End', artist: 'Linkin Park', duration: '3:36'),
    Track(title: 'Shape of You', artist: 'Ed Sheeran', duration: '3:53'),
    Track(title: 'Blinding Lights', artist: 'The Weeknd', duration: '3:20'),
    Track(title: 'Bohemian Rhapsody', artist: 'Queen', duration: '5:54'),
    Track(title: 'Thunderstruck', artist: 'AC/DC', duration: '4:52'),
    Track(title: 'Stay', artist: 'The Kid LAROI & Justin Bieber', duration: '2:21'),
    Track(title: 'Believer', artist: 'Imagine Dragons', duration: '3:24'),
    Track(title: 'Heat Waves', artist: 'Glass Animals', duration: '3:58'),
    Track(title: 'Levitating', artist: 'Dua Lipa', duration: '3:23'),
    Track(title: 'Perfect', artist: 'Ed Sheeran', duration: '4:23'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мій Плейлист (Варіант 9)'),
        centerTitle: true,
        // Змінено на стандартний колір
        backgroundColor: Colors.indigo.withOpacity(0.2),
      ),
      body: ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          return TrackItemWidget(track: tracks[index]);
        },
      ),
    );
  }
}

class TrackItemWidget extends StatelessWidget {
  final Track track;

  const TrackItemWidget({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.indigo,
          child: Icon(Icons.music_note, color: Colors.white),
        ),
        title: Text(
          track.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${track.artist} • ${track.duration}'),
        // Виконання умови варіанта 9: іконка "play" [cite: 38]
        trailing: const Icon(Icons.play_arrow, color: Colors.green, size: 30),
      ),
    );
  }
}