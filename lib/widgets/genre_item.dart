import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/genre.dart';

class GenreItem extends StatelessWidget {
  final Genre genre;
  final int trackCount;
  final VoidCallback onSelect;

  const GenreItem({
    super.key,
    required this.genre,
    required this.trackCount,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              genre.color.withValues(alpha: 0.55),
              genre.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(genre.icon, color: Colors.white, size: 30),
            const Spacer(),
            Text(
              genre.name,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Треків: $trackCount',
              style: GoogleFonts.lato(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}