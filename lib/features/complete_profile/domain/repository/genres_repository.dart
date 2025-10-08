import 'package:prism/features/complete_profile/domain/entities/genre_entity.dart';

abstract class GenresRepository {
  Future<List<GenreEntity>> getGenres({required String lang, required String type});
}
