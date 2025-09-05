import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/locator.dart';
import 'package:prism/features/auth/domain/repository/auth_repository.dart';
import 'package:prism/features/auth/presentation/view_model/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((
  ref,
) {
  return AuthViewModel(locator<AuthRepository>());
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthViewModel(this._repository) : super(AuthInitial()) {
    _repository.user.listen((user) {
      if (user != null) {
        state = Authenticated(user);
      } else {
        state = Unauthenticated();
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      state = AuthLoading();
      await _repository.signIn(email, password);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      state = AuthLoading();
      await _repository.signUp(email, password, name);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = AuthLoading();
      await _repository.signInWithGoogle();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }
}
