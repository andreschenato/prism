import 'package:prism/features/complete_profile/data/sources/genres_source.dart';
import 'package:prism/features/complete_profile/domain/entities/genre_entity.dart';
import 'package:prism/features/complete_profile/domain/repository/genres_repository.dart';

class GenresRepositoryImpl implements GenresRepository {
  final GenresSource _genresSource;
  GenresRepositoryImpl(this._genresSource);

  @override
  Future<List<GenreEntity>> getGenres({required String lang, required String type}) async {
    try {
      final mediaModels = await _genresSource.fetchGenres(lang: lang, type: type);
      return mediaModels.map((model) => model.toEntity()).toList();
    } catch (error) {
      throw Exception('Failed to load genres list: $error');
    }
  }
}
