class PersonEntity {
  final int id;
  final String name;
  final String? character;
  final String? photo;

  PersonEntity({
    required this.id,
    required this.name,
    this.character,
    this.photo,
  });
}
