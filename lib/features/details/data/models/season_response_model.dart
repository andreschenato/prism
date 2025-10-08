import 'package:prism/features/details/domain/entities/season_entity.dart';

class SeasonResponseModel {
  final int id;
  final String name;
  final String? photo;

  SeasonResponseModel({
    required this.id,
    required this.name,
    this.photo,
  });

  factory SeasonResponseModel.fromJson(Map<String, dynamic> json) {
    return SeasonResponseModel(
      id: json['id'],
      name: json['name'],
      photo: 'https://image.tmdb.org/t/p/w185/${json['poster_path']}',
    );
  }

  SeasonEntity toEntity() {
    return SeasonEntity(
      id: id,
      name: name,
      photo: photo,
    );
  }
}
