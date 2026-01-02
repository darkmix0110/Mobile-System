class Track {
  final String id, title, artist, duration, genreId;
  Track({required this.id, required this.title, required this.artist, required this.duration, required this.genreId});

  // copyWith потрібен для безпечного редагування треків у Riverpod
  Track copyWith({String? title, String? artist, String? duration, String? genreId}) {
    return Track(
      id: id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      genreId: genreId ?? this.genreId,
    );
  }
}