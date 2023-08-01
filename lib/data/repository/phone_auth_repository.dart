import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<bool> isLoggedIn() async {
    final currentUser = auth.currentUser;
    return currentUser != null;
  }

  Future signOut() async {
    auth.signOut();
  }
}
