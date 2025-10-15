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

    final resultsList = [...movieList, ...tvList];

    return resultsList
        .map((mediaJson) => MediaResponseModel.fromJson(mediaJson))
        .toList();
  }

  /// Fetch media details from TMDB using media IDs and types
  Future<List<MediaResponseModel>> fetchMediaDetailsFromTMDB(
    List<Map<String, String>> mediaItems,
  ) async {
    String? apiKey = dotenv.env['TMDB_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('TMDB_API_KEY not found in .env');
    }

    print('Fetching media details for items: $mediaItems');

    // Cria todas as futures de uma vez
    final List<Future<MediaResponseModel>> futures = mediaItems.map((
      item,
    ) async {
      final id = item['id'];
      final type = item['type'];
      if (id == null || type == null) {
        throw Exception('Invalid media item: $item');
      }

      final endpoint = type == 'movie' ? '/3/movie/$id' : '/3/tv/$id';

      try {
        final media = await _apiClient.get(
          endpoint,
          headers: {'Authorization': 'Bearer $apiKey'},
        );

        if (media == null) {
          print(
            'Media not found by ID, attempting search by title: ${item['title']}',
          );

          final searchResults = await _apiClient.get(
            '/3/search/movie?query=${item['title']}',
            headers: {'Authorization': 'Bearer $apiKey'},
          );

          if (searchResults != null &&
              searchResults['results'] != null &&
              searchResults['results'].isNotEmpty) {
            final firstResult = searchResults['results'][0];
            return MediaResponseModel.fromJson({...firstResult, 'type': type});
          }
        }

        print('Fetched individual media data: $media');

        return MediaResponseModel.fromJson({...media, 'type': type});
      } catch (e) {
        print('Error fetching media: $e');
        rethrow;
      }
    }).toList();

    // Executa todas as requisições em paralelo
    final mediaList = await Future.wait(futures);

    return mediaList;
  }
}
