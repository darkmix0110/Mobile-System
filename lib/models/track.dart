class Track {
  final String title;
  final String artist;
  final String duration;

  // Константний конструктор для оптимізації 
  const Track({
    required this.title,
    required this.artist,
    required this.duration,
  });
}