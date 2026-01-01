import 'package:flutter/material.dart';
import '../models/track.dart';

class NewTrack extends StatefulWidget {
  final Function(String, String, String) onAdd;
  final Track? existingTrack; // Якщо не null — ми в режимі редагування

  const NewTrack({super.key, required this.onAdd, this.existingTrack});

  @override
  State<NewTrack> createState() => _NewTrackState();
}

class _NewTrackState extends State<NewTrack> {
  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingTrack != null) {
      _titleController.text = widget.existingTrack!.title;
      _artistController.text = widget.existingTrack!.artist;
      _durationController.text = widget.existingTrack!.duration;
    }
  }

  void _submitData() {
    if (_titleController.text.isEmpty || _artistController.text.isEmpty) return;
    widget.onAdd(_titleController.text, _artistController.text, _durationController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Назва треку')),
          TextField(controller: _artistController, decoration: const InputDecoration(labelText: 'Виконавець')),
          TextField(controller: _durationController, decoration: const InputDecoration(labelText: 'Тривалість (н-р 3:45)')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _submitData, child: Text(widget.existingTrack == null ? 'Додати' : 'Зберегти')),
        ],
      ),
    );
  }
}