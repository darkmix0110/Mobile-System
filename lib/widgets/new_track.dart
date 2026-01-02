import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/track.dart';
import '../providers/genres_provider.dart';

class NewTrack extends ConsumerStatefulWidget {
  final Track? existingTrack;
  final String? initialGenreId;

  const NewTrack({super.key, this.existingTrack, this.initialGenreId});

  @override
  ConsumerState<NewTrack> createState() => _NewTrackState();
}

class _NewTrackState extends ConsumerState<NewTrack> {
  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _durationController = TextEditingController();
  String? _selectedGenreId;

  @override
  void initState() {
    super.initState();
    if (widget.existingTrack != null) {
      _titleController.text = widget.existingTrack!.title;
      _artistController.text = widget.existingTrack!.artist;
      _durationController.text = widget.existingTrack!.duration;
      _selectedGenreId = widget.existingTrack!.genreId;
    } else {
      _selectedGenreId = widget.initialGenreId;
    }
  }

  void _save() {
    if (_titleController.text.isEmpty || _selectedGenreId == null) return;
    final trackData = {
      'title': _titleController.text,
      'artist': _artistController.text,
      'duration': _durationController.text,
      'genreId': _selectedGenreId!,
    };
    Navigator.of(context).pop(trackData);
  }

  @override
  Widget build(BuildContext context) {
    final genres = ref.watch(genresProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16, right: 16, top: 16
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Назва')),
          TextField(controller: _artistController, decoration: const InputDecoration(labelText: 'Виконавець')),
          TextField(controller: _durationController, decoration: const InputDecoration(labelText: 'Тривалість')),
          DropdownButtonFormField<String>(
            value: _selectedGenreId,
            items: genres.map((g) => DropdownMenuItem(
              value: g.id, 
              child: Row(children: [Icon(g.icon, size: 18), const SizedBox(width: 8), Text(g.name)])
            )).toList(),
            onChanged: (val) => setState(() => _selectedGenreId = val),
            decoration: const InputDecoration(labelText: 'Жанр'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _save, child: const Text('Зберегти')),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}