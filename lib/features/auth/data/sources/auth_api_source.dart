import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prism/features/auth/domain/entities/user_entity.dart';

class AuthApiSource {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<UserEntity?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? null
          : UserEntity(id: firebaseUser.uid, email: firebaseUser.email, name: firebaseUser.displayName);
    });
  }

  Future<UserEntity?> signIn(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = userCredential.user;

    return firebaseUser == null
        ? null
        : UserEntity(id: firebaseUser.uid, email: firebaseUser.email, name: firebaseUser.displayName);
  }

  Future<UserEntity?> signUp(String email, String password, String name) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = userCredential.user;

    await firebaseUser?.updateDisplayName(name);

    return firebaseUser == null
        ? null
        : UserEntity(id: firebaseUser.uid, email: firebaseUser.email, name: firebaseUser.displayName);
  }

  Future<UserEntity?> signInWithGoogle() async {
    String? serverClientId = dotenv.env['SERVER_CLIENT_ID'];

    await _googleSignIn.initialize(serverClientId: serverClientId);

    GoogleSignInAccount? account = await _googleSignIn
        .attemptLightweightAuthentication();

    if (account == null) {
      throw FirebaseAuthException(
        code: 'SignIn aborted by user',
        message: 'User aborted sign in',
      );
    }

    final idToken = account.authentication.idToken;
    final authClient = account.authorizationClient;

    GoogleSignInClientAuthorization? auth = await authClient
        .authorizationForScopes(['email', 'settings']);

    if (auth == null) {
      throw FirebaseAuthException(code: 'No acceess token provided');
    }

    final accessToken = auth.accessToken;

    final credential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final firebaseUser = userCredential.user;
    return firebaseUser == null
        ? null
        : UserEntity(id: firebaseUser.uid, email: firebaseUser.email, name: firebaseUser.displayName);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
