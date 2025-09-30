import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prism/core/api/api_client.dart';
import 'package:prism/features/complete_profile/data/models/genre_model.dart';

class GenresSource {
  final _apiClient = ApiClient(baseUrl: 'https://api.themoviedb.org');

  Future<List<GenreModel>> fetchGenres({required String lang, required String type}) async {
    lang = lang.isEmpty ? 'en-US' : lang;
    type = type.isEmpty ? 'movie' : type;
    String? apiKey = dotenv.env['TMDB_API_KEY'];
    var headers = <String, String>{'Authorization': 'Bearer $apiKey'};
    final responseData = await _apiClient.get(
      '/3/genre/$type/list?language=$lang',
      headers: Map.from(headers),
    );
    final resultsList = responseData['genres'] as List;
    return resultsList
        .map((genreJson) => GenreModel.fromJson(genreJson))
        .toList();
  }
}
