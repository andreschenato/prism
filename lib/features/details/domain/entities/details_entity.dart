import 'package:prism/features/details/domain/entities/person_entity.dart';

class DetailsEntity {
  final String id;
  final String title;
  final String plot;
  final String? posterUrl;
  final List genres;
  final int startYear;
  final int? endYear;
  final List<PersonEntity> directors;
  final List<PersonEntity> writers;
  final List<PersonEntity> actors;
  final List? seasons;

  DetailsEntity({
    required this.id,
    required this.title,
    this.posterUrl,
    required this.plot,
    required this.genres,
    required this.startYear,
    this.endYear,
    required this.directors,
    required this.writers,
    required this.actors,
    this.seasons,
  });
}
