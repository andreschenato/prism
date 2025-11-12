import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';

class FavoriteSource {
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  Future<MediaEntity?> favoriteMedia(
    String poster,
    int id,
    String type,
    String title,
  ) async {
    final current = await _firestore
        .collection('users')
        .doc(_user?.uid)
        .collection(type)
        .doc(id.toString())
        .get();
    if (current.exists) {
      await _firestore
          .collection('users')
          .doc(_user?.uid)
          .collection(type)
          .doc(id.toString())
          .delete();

      return null;
    }

    String lowerTitle = title.toLowerCase();
    List<String> splitTitle = lowerTitle.split(' ');
    List<String> searchTerms = [];
    for (var i = 0; i < splitTitle.length; i++) {
      for (var j = 0; j < splitTitle[i].length; j++) {
        searchTerms.add(splitTitle[i].substring(0, j+1));
      }
    }

    await _firestore
        .collection('users')
        .doc(_user?.uid)
        .collection(type)
        .doc(id.toString())
        .set({
          "poster_url": poster,
          "title": title,
          "search_terms": searchTerms,
        });

    return MediaEntity(id: id, title: title, type: type, posterUrl: poster);
  }
}
