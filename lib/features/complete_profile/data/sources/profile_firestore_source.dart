import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prism/features/auth/domain/entities/user_entity.dart';

class ProfileFirestoreSource {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<UserEntity?> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return null;
      }

      final docSnapshot = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      final docData = docSnapshot.data();

      final Map<String, dynamic> genres = docData?['genre_ids'];
      final String language = docData?['language'];
      final String countryCode = docData?['country_code'];

      return UserEntity(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        name: firebaseUser.displayName,
        genreIds: genres,
        language: language,
        countryCode: countryCode,
      );
    });
  }

  Future<UserEntity?> setUserProfilePreferences(
    Map genreIds,
    String country,
    String language,
    String userId,
  ) async {
    await _firestore.collection('users').doc(userId).set({
      "genre_ids": genreIds,
      "country_code": country,
      "language": language,
    });

    return UserEntity(
      id: userId,
      genreIds: genreIds,
      countryCode: country,
      language: language,
    );
  }
}
