class SeasonEntity {
  final int id;
  final String name;
  final String? photo;

  SeasonEntity({
    required this.id,
    required this.name,
    this.photo,
  });
}
