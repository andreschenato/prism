class UserEntity {
  final String id;
  final String? email;
  final String? name;
  final String? countryCode;
  final String? language;
  final Map? genreIds;

  UserEntity({
    required this.id,
    this.email,
    this.name,
    this.countryCode,
    this.genreIds,
    this.language,
  });
}
