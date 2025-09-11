import 'package:prism/features/auth/data/sources/auth_api_source.dart';
import 'package:prism/features/auth/domain/entities/user_entity.dart';
import 'package:prism/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiSource _apiSource;
  AuthRepositoryImpl(this._apiSource);

  @override
  Stream<UserEntity?> get user => _apiSource.user;

  @override
  Future<UserEntity?> signIn(String email, String password) {
    return _apiSource.signIn(email, password);
  }

  @override
  Future<void> signOut() {
    return _apiSource.signOut();
  }

  @override
  Future<UserEntity?> signUp(String email, String password, String name) {
    return _apiSource.signUp(email, password, name);
  }

  @override
  Future<UserEntity?> signInWithGoogle() {
    return _apiSource.signInWithGoogle();
  }
}
