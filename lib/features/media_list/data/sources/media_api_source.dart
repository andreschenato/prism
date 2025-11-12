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
    final List<Future<MediaResponseModel?>> futures = mediaItems.map((
      item,
    ) async {
      final id = item['id'];
      final type = item['type'];
      final title = item['title'];

      if (id == null || type == null || title == null) {
        throw Exception('Invalid media item: $item');
      }

      try {
        // Primeiro tenta buscar por título
        final encodedTitle = Uri.encodeComponent(title);
        final searchEndpoint = type == 'movie'
            ? '/3/search/movie?query=$encodedTitle&language=pt-BR'
            : '/3/search/tv?query=$encodedTitle&language=pt-BR';

        print('Searching for $type by title: $title');

        final searchResults = await _apiClient.get(
          searchEndpoint,
          headers: {'Authorization': 'Bearer $apiKey'},
        );

        if (searchResults != null &&
            searchResults['results'] != null &&
            searchResults['results'].isNotEmpty) {
          final firstResult = searchResults['results'][0];
          print(
            'Found by title: ${firstResult['title'] ?? firstResult['name']}',
          );

          return MediaResponseModel.fromJson({...firstResult, 'type': type});
        }

        // Se não encontrou por título, tenta por ID (fallback)
        print('Not found by title, trying by ID: $id');

        final idEndpoint = type == 'movie' ? '/3/movie/$id' : '/3/tv/$id';

        final mediaById = await _apiClient.get(
          idEndpoint,
          headers: {'Authorization': 'Bearer $apiKey'},
        );

        if (mediaById != null) {
          print('Found by ID: $id');
          return MediaResponseModel.fromJson({...mediaById, 'type': type});
        }

        // Se ambos falharam
        print('Media not found by title or ID: $title (ID: $id)');
        return null;
      } catch (e) {
        print('Error fetching media "$title": $e');
        return null;
      }
    }).toList();

    final results = await Future.wait(futures);
    final mediaList = results.whereType<MediaResponseModel>().toList();

    print(
      'Successfully fetched ${mediaList.length} out of ${mediaItems.length} media items',
    );

    return mediaList;
  }

  Future<List<MediaResponseModel>> searchMedia({
    String query = '',
    int page = 1,
    String lang = 'en-US',
  }) async {
    String? apiKey = dotenv.env['TMDB_API_KEY'];
    var headers = <String, String>{'Authorization': 'Bearer $apiKey'};
    final movies = await _apiClient.get(
      '/3/search/movie?query=$query&include_adult=false&include_video=false&language=$lang&page=$page',
      headers: Map.from(headers),
    );
    final series = await _apiClient.get(
      '/3/search/tv?query=$query&include_adult=false&include_video=false&language=$lang&page=$page',
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
}
