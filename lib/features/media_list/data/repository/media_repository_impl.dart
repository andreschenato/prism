import 'package:prism/features/media_list/data/sources/favorites_source.dart';
import 'package:prism/features/media_list/data/sources/media_api_source.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';
import 'package:prism/features/media_list/domain/repository/media_repository.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaApiSource _apiSource;
  final FavoritesSource _favoritesSource;
  MediaRepositoryImpl(this._apiSource, this._favoritesSource);

  @override
  Future<List<MediaEntity>> getMedia({
    int page = 1,
    String lang = 'en-US',
  }) async {
    try {
      final mediaModels = await _apiSource.fetchMedia(page: page, lang: lang);
      return mediaModels.map((model) => model.toEntity()).toList();
    } catch (error) {
      throw Exception('Failed to load media list: $error');
    }
  }

  @override
  Future<List<MediaEntity>> getFavorites() async {
    try {
      final favorites = await _favoritesSource.getMedia();
      return favorites;
    } catch (error) {
      throw Exception('Failed to load favorites list: $error');
    }
  }

  @override
  Future<List<MediaEntity>> getMediaDetails(
    List<Map<String, String>> recommendations,
  ) async {
    try {
      final mediaModels = await _apiSource.fetchMediaDetailsFromTMDB(
        recommendations,
      );

      final validMedia = mediaModels.where((media) => media != null).toList();

      return validMedia.map((model) => model.toEntity()).toList();
    } catch (error) {
      print('Error fetching media details: $error');
      throw Exception('Failed to load media details: $error');
    }
  }

  @override
  Future<List<MediaEntity>> searchMedia({
    String query = '',
    int page = 1,
    String lang = 'en-US',
  }) async {
    try {
      final mediaModels = await _apiSource.searchMedia(
        query: query,
        page: page,
        lang: lang,
      );
      return mediaModels.map((model) => model.toEntity()).toList();
    } catch (error) {
      throw Exception('Failed to search media: $error');
    }
  }

  @override
  Future<List<MediaEntity>> searchFavorite(String text) async {
    try {
      final favorites = await _favoritesSource.searchMedia(text);
      return favorites;
    } catch (error) {
      throw Exception('Failed to load favorites list: $error');
    }
  }
}
