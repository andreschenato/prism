import 'package:prism/features/details/data/models/person_response_model.dart';
import 'package:prism/features/details/domain/entities/details_entity.dart';

class DetailsResponseModel {
  final int id;
  final String title;
  final String plot;
  final String? poster;
  final List genres;
  final int startYear;
  final int? endYear;
  final List<PersonResponseModel> directors;
  final List<PersonResponseModel> writers;
  final List<PersonResponseModel> actors;
  final List? seasons;

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
    this.seasons,
  });

  factory DetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final genresList = json['genres'] as List;
    List<String> genres = genresList.map((i) => i['name'] as String).toList();

    final crewList = json['credits']['crew'] as List;
    List<PersonResponseModel> directors = crewList
        .where((p) => p['job'] == 'Director')
        .map((p) => PersonResponseModel.fromJson(p))
        .toList();
    directors = _uniquePerson(directors);

    List<PersonResponseModel> writers = crewList
        .where(
          (p) =>
              p['job'] == 'Writer' ||
              p['job'] == 'Story' ||
              p['job'] == 'Screenplay',
        )
        .map((p) => PersonResponseModel.fromJson(p))
        .toList();
    writers = _uniquePerson(writers);

    final actorsList = json['credits']['cast'] as List;
    List<PersonResponseModel> actors = actorsList
        .map((i) => PersonResponseModel.fromJson(i))
        .toList();

    // final seasonsData = json['seasons'];
    // List<String>? seasons;
    // if (seasonsData is List && seasonsData.isNotEmpty) {
    //   seasons = seasonsData.map((i) => i['season'] as String).toList();
    // }

    var startDate = json['release_date'] ?? json['first_air_date'];
    var endDate = json['last_air_date'] ?? '';

    return DetailsResponseModel(
      id: json['id'],
      title: json['title'],
      plot: json['overview'],
      poster: 'https://image.tmdb.org/t/p/w185/${json['poster_path']}',
      genres: genres,
      startYear: DateTime.parse(startDate).year,
      endYear: DateTime.tryParse(endDate)?.year,
      directors: directors,
      writers: writers,
      actors: actors,
      // seasons: seasons,
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
      // seasons: seasons,
    );
  }
}

List<PersonResponseModel> _uniquePerson(List<PersonResponseModel> persons) {
  final Map<String, PersonResponseModel> uniquePersonsMap = {};
  for (var person in persons) {
    uniquePersonsMap[person.name] = person;
  }

  return uniquePersonsMap.values.toList();
}
