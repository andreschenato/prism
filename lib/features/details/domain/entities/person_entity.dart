class PersonEntity {
  final String id;
  final String name;
  final String? photo;

  PersonEntity({
    required this.id,
    required this.name,
    this.photo,
  });
}
