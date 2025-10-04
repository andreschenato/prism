import 'package:prism/features/media_list/domain/entities/media_entity.dart';

class MediaResponseModel {
  final int id;
  final String title;
  final String? poster;
  final String type;

  MediaResponseModel({required this.id, required this.title, this.poster, required this.type});

  factory MediaResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return MediaResponseModel(
      id: json['id'],
      title: json['title'] ?? json['name'],
      poster: 'https://image.tmdb.org/t/p/w185/${json['poster_path']}',
      type: json['type'],
    );
  }

  MediaEntity toEntity() {
    return MediaEntity(id: id, title: title, posterUrl: poster, type: type);
  }
}
