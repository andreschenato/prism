import 'package:prism/core/api/api_client.dart';
import 'package:prism/features/details/data/models/details_response_model.dart';

class DetailsApiSource {
  final _apiClient = ApiClient(baseUrl: 'https://api.imdbapi.dev');

  Future<DetailsResponseModel> fetchMedia(String id) async {
    final responseData = await _apiClient.get('/titles/$id') as Map<String, dynamic>;
    return DetailsResponseModel.fromJson(responseData);
  }
}
