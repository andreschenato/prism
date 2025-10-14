import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prism/core/api/api_client.dart';
import 'package:prism/features/details/data/models/details_response_model.dart';

class DetailsApiSource {
  final _apiClient = ApiClient(baseUrl: 'https://api.themoviedb.org');

  Future<DetailsResponseModel> fetchMedia(
    String id,
    String lang,
    String type,
  ) async {
    String? apiKey = dotenv.env['TMDB_API_KEY'];
    var headers = <String, String>{'Authorization': 'Bearer $apiKey'};
    final responseData =
        await _apiClient.get(
              '/3/$type/$id?append_to_response=credits&language=$lang',
              headers: Map.from(headers),
            )
            as Map<String, dynamic>;

    bool isFavorite = await _isFavorite(responseData['id']);

    responseData.putIfAbsent("is_favorite", () => isFavorite);

    return DetailsResponseModel.fromJson(responseData);
  }

  Future<bool> _isFavorite(int id) async {
    final firestore = FirebaseFirestore.instance;
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      return false;
    }

    final userData = firestore.collection('users').doc(firebaseUser.uid);

    final movies = await userData.collection("movie").get();
    final tv = await userData.collection("tv").get();

    final media = [...movies.docs, ...tv.docs];

    return media.any((doc) => doc.id == id.toString());
  }
}
