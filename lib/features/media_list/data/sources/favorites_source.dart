import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';

class FavoritesSource {
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  Future<List<MediaEntity>> getMedia() async {
    final user = _firestore.collection('users').doc(_user?.uid);

    final movies = await user.collection('movie').get();
    final tv = await user.collection('tv').get();

    List<MediaEntity> media = [];

    for (var m in movies.docs) {
      MediaEntity movie = MediaEntity(
        id: int.parse(m.id),
        title: m.get("title"),
        type: "movie",
        posterUrl: m.get("poster_url"),
      );

      media.add(movie);
    }

    for (var t in tv.docs) {
      MediaEntity tv = MediaEntity(
        id: int.parse(t.id),
        title: t.get("title"),
        type: "tv",
        posterUrl: t.get("poster_url"),
      );

      media.add(tv);
    }

    return media;
  }

  Future<List<MediaEntity>> searchMedia(String text) async {
    final user = _firestore.collection('users').doc(_user?.uid);

    String lowerTitle = text.toLowerCase();
    List<String> searchTerms = lowerTitle.split(' ');

    final movies = await user
        .collection('movie')
        .where('search_terms', arrayContainsAny: searchTerms)
        .get();
    final tv = await user
        .collection('tv')
        .where('search_terms', arrayContainsAny: searchTerms)
        .get();

    List<MediaEntity> media = [];

    for (var m in movies.docs) {
      MediaEntity movie = MediaEntity(
        id: int.parse(m.id),
        title: m.get("title"),
        type: "movie",
        posterUrl: m.get("poster_url"),
      );

      media.add(movie);
    }

    for (var t in tv.docs) {
      MediaEntity tv = MediaEntity(
        id: int.parse(t.id),
        title: t.get("title"),
        type: "tv",
        posterUrl: t.get("poster_url"),
      );

      media.add(tv);
    }

    return media;
  }
}
