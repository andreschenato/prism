import 'package:prism/features/auth/domain/entities/user_entity.dart';

abstract class CompleteProfileRepository {
  Future<UserEntity?> setUserProfilePreferences(
    List genreIds,
    String country,
    String language,
    String userId,
  );
  Stream<UserEntity?> get user;
}
