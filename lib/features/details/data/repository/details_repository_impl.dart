import 'package:prism/features/details/data/sources/details_api_source.dart';
import 'package:prism/features/details/data/sources/favorite_source.dart';
import 'package:prism/features/details/domain/entities/details_entity.dart';
import 'package:prism/features/details/domain/repository/details_repository.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsApiSource _apiSource;
  final FavoriteSource _favoriteSource;
  DetailsRepositoryImpl(this._apiSource, this._favoriteSource);

  @override
  Future<DetailsEntity> getMediaDetails(String id, String lang, type) async {
    try {
      final mediaModel = await _apiSource.fetchMedia(id, lang, type);
      return mediaModel.toEntity();
    } catch (error) {
      throw Exception('Failed to load media details: $error');
    }
  }

  @override
  Future<MediaEntity?> favoriteMedia(int id, String poster, String type, String title) async {
    try {
      final response = await _favoriteSource.favoriteMedia(poster, id, type, title);
      return response;
    } catch (error) {
      throw Exception('Failed to favorite media: $error');
    }
  }
}
