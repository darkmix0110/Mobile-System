import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/genre.dart';

final genresProvider = Provider((ref) => const [
  Genre(id: 'g1', name: 'Поп', color: Colors.pink, icon: Icons.audiotrack),
  Genre(id: 'g2', name: 'Рок', color: Colors.orange, icon: Icons.album),
  Genre(id: 'g3', name: 'Джаз', color: Colors.blue, icon: Icons.library_music),
  Genre(id: 'g4', name: 'Реп', color: Colors.purple, icon: Icons.mic),
]);