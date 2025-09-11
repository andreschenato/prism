import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prism/core/api/api_client.dart';
import 'package:prism/features/media_list/data/models/media_response_model.dart';

class MediaApiSource {
  final _apiClient = ApiClient(baseUrl: 'https://api.themoviedb.org');

  Future<List<MediaResponseModel>> fetchMedia() async {
    String? apiKey = dotenv.env['TMDB_API_KEY'];
    var headers = <String, String>{'Authorization': 'Bearer $apiKey'};
    final responseData = await _apiClient.get('/3/discover/movie?language=pt-BR&page=1', headers: Map.from(headers));
    final resultsList = responseData['results'] as List;
    return resultsList
        .map((mediaJson) => MediaResponseModel.fromJson(mediaJson))
        .toList();
  }
}
