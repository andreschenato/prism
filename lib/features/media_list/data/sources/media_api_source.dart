import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prism/core/api/api_client.dart';
import 'package:prism/features/media_list/data/models/media_response_model.dart';

class MediaApiSource {
  final _apiClient = ApiClient(baseUrl: 'https://api.themoviedb.org');

  Future<List<MediaResponseModel>> fetchMedia({
    int page = 1,
    String lang = 'en-US',
  }) async {
    String? apiKey = dotenv.env['TMDB_API_KEY'];
    var headers = <String, String>{'Authorization': 'Bearer $apiKey'};
    final movies = await _apiClient.get(
      '/3/discover/movie?include_adult=false&include_video=false&language=$lang&page=$page&sort_by=popularity.desc&vote_count.gte=80',
      headers: Map.from(headers),
    );
    final series = await _apiClient.get(
      '/3/discover/tv?include_adult=false&include_video=false&language=$lang&page=$page&sort_by=popularity.desc&vote_count.gte=80',
      headers: Map.from(headers),
    );

    final movieList = (movies['results'] as List).map((m) {
      return {...m, 'type': 'movie'};
    }).toList();

    final tvList = (series['results'] as List).map((s) {
      return {...s, 'type': 'tv'};
    }).toList();

    final resultsList = [
      ...movieList,
      ...tvList,
    ];

    return resultsList
        .map((mediaJson) => MediaResponseModel.fromJson(mediaJson))
        .toList();
  }
}
