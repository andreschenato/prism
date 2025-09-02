import 'package:prism/core/api/api_client.dart';
import 'package:prism/features/media_list/data/models/media_response_model.dart';

class MediaApiSource {
  final _apiClient = ApiClient(baseUrl: 'https://api.imdbapi.dev');

  Future<List<MediaResponseModel>> fetchMedia() async {
    final responseData = await _apiClient.get('/titles');
    final resultsList = responseData['titles'] as List;
    return resultsList
        .map((mediaJson) => MediaResponseModel.fromJson(mediaJson))
        .toList();
  }
}
