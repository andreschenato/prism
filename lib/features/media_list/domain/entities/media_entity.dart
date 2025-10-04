class MediaEntity {
  final int id;
  final String title;
  final String? posterUrl;
  final String type;

  MediaEntity({
    required this.id,
    required this.title,
    this.posterUrl,
    required this.type,
  });
}
