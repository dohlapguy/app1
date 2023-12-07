import 'dart:async';

import 'package:app1/core/error/auth_failure.dart';
import 'package:app1/core/error/failure.dart';
import 'package:app1/core/network/network_info.dart';
import 'package:app1/core/utils/typedef.dart';
import 'package:app1/domain/repository/phone_auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final NetworkInfo networkInfo;
  final FirebaseAuth firebaseAuth;

  AuthRepoImpl({required this.networkInfo, required this.firebaseAuth});

  @override
  ResultFuture<String> verifyPhone({
    required String phoneNumber,
  }) async {
    Completer<Either<Failure, String>> completer = Completer();

    if (await networkInfo.isConnected) {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (credential) async {
            try {
              await firebaseAuth.signInWithCredential(credential);
              completer.complete(right('Verification Completed'));
            } catch (e) {
              completer.complete(left(const ServerFailure()));
            }
          },
          codeSent: (verificationId, forceResendingToken) {
            completer.complete(right(verificationId));
          },
          codeAutoRetrievalTimeout: (verificationId) {},
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == "session-expired") {
              completer.complete(left(const SessionExpiredFailure()));
            } else if (e.code == "ınvalıd-verıfıcatıon-code" ||
                e.code == "invalid-verification-code") {
              completer.complete(left(const InvalidVerificationCodeFailure()));
            } else {
              completer.complete(left(const ServerFailure()));
            }
          });

      return completer.future;
    } else {
      return left(const NoInternetConnectionFailure());
    }
  }

  @override
  ResultVoid verifyOtp(
      {required String verificationId, required String otpCode}) async {
    if (await networkInfo.isConnected) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otpCode,
        );
        final user = await firebaseAuth.signInWithCredential(credential);
        if (user.user == null) {
          return left(const UserNotFoundFailure());
        }
        return right(null);
      } on FirebaseAuthException catch (e) {
        if (e.code == "session-expired") {
          return left(const SessionExpiredFailure());
        } else if (e.code == "ınvalıd-verıfıcatıon-code" ||
            e.code == "invalid-verification-code") {
          return left(const InvalidVerificationCodeFailure());
        }
        return left(const ServerFailure());
      }
    } else {
      return left(const NoInternetConnectionFailure());
    }
  }

  @override
  ResultVoid signOut() async {
    try {
      firebaseAuth.signOut();
      return right(null);
    } on Exception {
      return left(const ServerFailure());
    }
  }

  @override
  Stream<bool> isLoggedIn() async* {
    final StreamController<bool> isLoggedInStreamController =
        StreamController();

    late bool result;

    final StreamSubscription<User?> subscription =
        firebaseAuth.authStateChanges().listen((User? user) {
      result = user != null;
      isLoggedInStreamController.add(result);
    });

    try {
      yield* isLoggedInStreamController.stream;
    } finally {
      await isLoggedInStreamController.close();
      await subscription.cancel();
    }
  }
}
