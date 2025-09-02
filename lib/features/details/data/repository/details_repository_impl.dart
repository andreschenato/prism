import 'package:prism/features/details/data/sources/details_api_source.dart';
import 'package:prism/features/details/domain/entities/details_entity.dart';
import 'package:prism/features/details/domain/repository/details_repository.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsApiSource _apiSource;
  DetailsRepositoryImpl(this._apiSource);

  @override
  Future<DetailsEntity> getMediaDetails(String id) async {
    try {
      final mediaModel = await _apiSource.fetchMedia(id);
      return mediaModel.toEntity();
    } catch (error) {
      throw Exception('Failed to load media details: $error');
    }
  }
}
