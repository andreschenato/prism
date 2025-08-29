class DetailsEntity {
  final String id;
  final String title;
  final String plot;
  final String? posterUrl;
  final List genres;

  DetailsEntity({
    required this.id,
    required this.title,
    this.posterUrl,
    required this.plot,
    required this.genres,
  });
}
