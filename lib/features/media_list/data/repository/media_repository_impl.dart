import 'package:prism/features/media_list/data/sources/media_api_source.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';
import 'package:prism/features/media_list/domain/repository/media_repository.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaApiSource _apiSource;
  MediaRepositoryImpl(this._apiSource);

  @override
  Future<List<MediaEntity>> getMedia({int page = 1}) async {
    try {
      final mediaModels = await _apiSource.fetchMedia(page: page);
      return mediaModels.map((model) => model.toEntity()).toList();
    } catch (error) {
      throw Exception('Failed to load media list: $error');
    }
  }
}
