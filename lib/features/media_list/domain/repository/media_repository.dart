import 'package:prism/features/media_list/domain/entities/media_entity.dart';

abstract class MediaRepository {
  Future<List<MediaEntity>> getMedia({int page = 1, String lang = 'en-US'});
  Future<List<MediaEntity>> getFavorites();
  Future<List<MediaEntity>> searchFavorite(String text);
  Future<List<MediaEntity>> getMediaDetails(
    List<Map<String, String>> recommendations,
  );
  Future<List<MediaEntity>> searchMedia({
    String query,
    int page = 1,
    String lang = 'en-US',
  });
}
