import 'package:prism/features/media_list/domain/entities/media_entity.dart';

abstract class MediaRepository {
  Future<List<MediaEntity>> getMedia({int page = 1, String lang = 'en-US'});
  Future<List<MediaEntity>> getMediaDetails(List<Map<String, String>> recommendations);
}