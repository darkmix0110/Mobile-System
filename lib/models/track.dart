class Track {
  final String id, title, artist, duration, genreId;

  Track({
    required this.id, 
    required this.title, 
    required this.artist, 
    required this.duration, 
    required this.genreId
  });

  // Перетворення об'єкта в карту для відправки (POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
      'genreId': genreId,
    };
  }

  // Створення об'єкта з даних Firebase (GET)
  factory Track.fromJson(String id, Map<String, dynamic> json) {
    return Track(
      id: id,
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      duration: json['duration'] ?? '',
      genreId: json['genreId'] ?? '',
    );
  }
}