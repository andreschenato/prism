import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prism/core/api/api_client.dart';
import 'package:prism/features/details/data/models/details_response_model.dart';

class DetailsApiSource {
  final _apiClient = ApiClient(baseUrl: 'https://api.themoviedb.org');

  Future<DetailsResponseModel> fetchMedia(String id, String lang, String type) async {
    String? apiKey = dotenv.env['TMDB_API_KEY'];
    var headers = <String, String>{'Authorization': 'Bearer $apiKey'};
    final responseData =
        await _apiClient.get(
              '/3/$type/$id?append_to_response=credits&language=$lang',
              headers: Map.from(headers),
            )
            as Map<String, dynamic>;
    return DetailsResponseModel.fromJson(responseData);
  }
}
