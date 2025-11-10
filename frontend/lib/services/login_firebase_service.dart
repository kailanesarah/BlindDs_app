import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

Future<UserCredential?> signInWithGoogle() async {
  if (kIsWeb) {
    return await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
  } else {
    // Android/iOS
    return await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
  }
}
