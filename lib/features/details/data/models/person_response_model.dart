import 'package:prism/features/details/domain/entities/person_entity.dart';

class PersonResponseModel {
  final String id;
  final String name;
  final String? photo;

  PersonResponseModel({
    required this.id,
    required this.name,
    this.photo,
  });

  factory PersonResponseModel.fromJson(Map<String, dynamic> json) {
    return PersonResponseModel(
      id: json['id'],
      name: json['displayName'],
      photo: json['primaryImage']?['url'],
    );
  }

  PersonEntity toEntity() {
    return PersonEntity(
      id: id,
      name: name,
      photo: photo,
    );
  }
}
