import 'package:prism/features/details/domain/entities/person_entity.dart';

class PersonResponseModel {
  final int id;
  final String name;
  final String? character;
  final String? photo;

  PersonResponseModel({
    required this.id,
    required this.name,
    this.character,
    this.photo,
  });

  factory PersonResponseModel.fromJson(Map<String, dynamic> json) {
    return PersonResponseModel(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      photo: 'https://image.tmdb.org/t/p/w185/${json['profile_path']}',
    );
  }

  PersonEntity toEntity() {
    return PersonEntity(
      id: id,
      name: name,
      character: character,
      photo: photo,
    );
  }
}
