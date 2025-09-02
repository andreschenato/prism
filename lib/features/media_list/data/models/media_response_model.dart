import 'package:prism/features/media_list/domain/entities/media_entity.dart';

class MediaResponseModel {
  final String id;
  final String title;
  final String? poster;

  MediaResponseModel({required this.id, required this.title, this.poster});

  factory MediaResponseModel.fromJson(Map<String, dynamic> json) {
    return MediaResponseModel(
      id: json['id'],
      title: json['primaryTitle'],
      poster: json['primaryImage']['url'],
    );
  }

  MediaEntity toEntity() {
    return MediaEntity(id: id, title: title, posterUrl: poster);
  }
}
