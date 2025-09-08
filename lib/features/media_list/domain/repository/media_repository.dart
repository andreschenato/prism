import 'package:prism/features/media_list/domain/entities/media_entity.dart';

abstract class MediaRepository {
  Future<List<MediaEntity>> getMedia({int page = 1});
}