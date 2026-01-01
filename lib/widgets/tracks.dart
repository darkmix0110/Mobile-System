import 'package:flutter/material.dart';
import '../models/track.dart';
import 'track_item.dart';
import 'new_track.dart';

class TracksScreen extends StatefulWidget {
  const TracksScreen({super.key});

  @override
  State<TracksScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen> {
  int _currentPlayingIndex = -1;
  final List<Track> _tracks = [
    Track(id: '1', title: 'In the End', artist: 'Linkin Park', duration: '3:36'),
    Track(id: '2', title: 'Shape of You', artist: 'Ed Sheeran', duration: '3:53'),
  ];

  void _openForm({Track? track}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => NewTrack(
        existingTrack: track,
        onAdd: (title, artist, duration) {
          if (track == null) {
            _addTrack(title, artist, duration);
          } else {
            _updateTrack(track.id, title, artist, duration);
          }
        },
      ),
    );
  }

  void _addTrack(String title, String artist, String duration) {
    setState(() {
      _tracks.add(Track(
        id: DateTime.now().toString(),
        title: title,
        artist: artist,
        duration: duration,
      ));
    });
  }

  void _updateTrack(String id, String title, String artist, String duration) {
    setState(() {
      final index = _tracks.indexWhere((t) => t.id == id);
      _tracks[index] = Track(id: id, title: title, artist: artist, duration: duration);
    });
  }

  void _removeTrack(String id) {
    final index = _tracks.indexWhere((t) => t.id == id);
    final removedTrack = _tracks[index];

    setState(() {
      _tracks.removeAt(index);
      if (_currentPlayingIndex == index) _currentPlayingIndex = -1;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Видалено: ${removedTrack.title}'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() => _tracks.insert(index, removedTrack));
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Музичний плеєр'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openForm(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _tracks.length,
        itemBuilder: (ctx, i) => TrackItem(
          track: _tracks[i],
          onDelete: _removeTrack,
          onEdit: () => _openForm(track: _tracks[i]),
          isPlaying: _currentPlayingIndex == i,
          onTogglePlay: () {
            setState(() {
              _currentPlayingIndex = (_currentPlayingIndex == i) ? -1 : i;
            });
          },
        ),
      ),
    );
  }
}