import 'package:prism/features/auth/domain/entities/user_entity.dart';
import 'package:prism/features/complete_profile/data/sources/profile_firestore_source.dart';
import 'package:prism/features/complete_profile/domain/repository/complete_profile_repository.dart';

class CompleteProfileRepositoryImpl implements CompleteProfileRepository {
  final ProfileFirestoreSource _firestoreSource;
  CompleteProfileRepositoryImpl(this._firestoreSource);

  @override
  Stream<UserEntity?> get user => _firestoreSource.user;

  @override
  Future<UserEntity?> setUserProfilePreferences(
    List genreIds,
    String country,
    String language,
    String userId,
  ) {
    return _firestoreSource.setUserProfilePreferences(
      genreIds,
      country,
      language,
      userId,
    );
  }
}
