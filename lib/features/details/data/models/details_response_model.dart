import 'package:prism/features/details/domain/entities/details_entity.dart';

class DetailsResponseModel {
  final String id;
  final String title;
  final String plot;
  final String? poster;
  final List genres;

  DetailsResponseModel({
    required this.id,
    required this.title,
    this.poster,
    required this.plot,
    required this.genres,
  });

  factory DetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return DetailsResponseModel(
      id: json['id'],
      title: json['primaryTitle'],
      plot: json['plot'],
      poster: json['primaryImage']['url'],
      genres: json['genres'],
    );
  }

  DetailsEntity toEntity() {
    return DetailsEntity(
      id: id,
      title: title,
      posterUrl: poster,
      plot: plot,
      genres: genres,
    );
  }
}
