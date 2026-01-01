import 'package:flutter/material.dart';
import '../models/track.dart';
import 'track_item.dart';

class TracksScreen extends StatefulWidget {
  const TracksScreen({super.key});

  @override
  State<TracksScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen> {
  // Змінна для зберігання індексу активного треку (-1 означає, що нічого не грає)
  int _currentPlayingIndex = -1;

  final List<Track> tracks = const [
    Track(title: 'In the End', artist: 'Linkin Park', duration: '3:36'),
    Track(title: 'Shape of You', artist: 'Ed Sheeran', duration: '3:53'),
    Track(title: 'Blinding Lights', artist: 'The Weeknd', duration: '3:20'),
    Track(title: 'Bohemian Rhapsody', artist: 'Queen', duration: '5:54'),
    Track(title: 'Thunderstruck', artist: 'AC/DC', duration: '4:52'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Музичний Плеєр'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          return TrackItem(
            track: tracks[index],
            // Перевіряємо, чи збігається поточний індекс із вибраним
            isPlaying: _currentPlayingIndex == index,
            onPlayTap: () {
              setState(() {
                if (_currentPlayingIndex == index) {
                  _currentPlayingIndex = -1; // Зупинити, якщо натиснули на той самий
                } else {
                  _currentPlayingIndex = index; // Почати грати цей трек
                }
              });
            },
          );
        },
      ),
    );
  }
}