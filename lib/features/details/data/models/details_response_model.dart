import 'package:prism/features/details/data/models/person_response_model.dart';
import 'package:prism/features/details/domain/entities/details_entity.dart';

class DetailsResponseModel {
  final String id;
  final String title;
  final String plot;
  final String? poster;
  final List genres;
  final int startYear;
  final int? endYear;
  final List<PersonResponseModel> directors;
  final List<PersonResponseModel> writers;
  final List<PersonResponseModel> actors;

  DetailsResponseModel({
    required this.id,
    required this.title,
    this.poster,
    required this.plot,
    required this.genres,
    required this.startYear,
    this.endYear,
    required this.directors,
    required this.writers,
    required this.actors,
  });

  factory DetailsResponseModel.fromJson(Map<String, dynamic> json) {
    var genresList = json['interests'] as List;
    List<String> genres = genresList
        .map((i) => i['name'] as String)
        .toList();
    var directorsList = json['directors'] as List;
    List<PersonResponseModel> directors = directorsList
        .map((i) => PersonResponseModel.fromJson(i))
        .toList();
    var writersList = json['writers'] as List;
    List<PersonResponseModel> writers = writersList
        .map((i) => PersonResponseModel.fromJson(i))
        .toList();
    var actorsList = json['stars'] as List;
    List<PersonResponseModel> actors = actorsList
        .map((i) => PersonResponseModel.fromJson(i))
        .toList();

    return DetailsResponseModel(
      id: json['id'],
      title: json['primaryTitle'],
      plot: json['plot'],
      poster: json['primaryImage']?['url'],
      genres: genres,
      startYear: json['startYear'],
      endYear: json['endYear'],
      directors: directors,
      writers: writers,
      actors: actors,
    );
  }

  DetailsEntity toEntity() {
    return DetailsEntity(
      id: id,
      title: title,
      posterUrl: poster,
      plot: plot,
      genres: genres,
      startYear: startYear,
      endYear: endYear,
      directors: directors.map((director) => director.toEntity()).toList(),
      writers: writers.map((writer) => writer.toEntity()).toList(),
      actors: actors.map((actor) => actor.toEntity()).toList(),
    );
  }
}
