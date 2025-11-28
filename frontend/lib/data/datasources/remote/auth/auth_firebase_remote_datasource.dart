import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthFirebaseDataSource {
  Future<UserCredential?> signInWithGoogle() async {
    if (kIsWeb) {
      return FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
    } else {
      return FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
    }
  }

  Future<String> getIdToken() async {
    final credential = await signInWithGoogle();

    if (credential == null || credential.user == null) {
      throw Exception("Login cancelado pelo usuário.");
    }

    final idToken = await credential.user!.getIdToken();

    if (idToken == null) {
      await FirebaseAuth.instance.signOut();
      throw Exception("Não foi possível obter o token do Firebase.");
    }

    return idToken;
  }
}
