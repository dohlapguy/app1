import 'package:app1/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

abstract class AuthRepo {
  ResultFuture<String> verifyPhone({required String phoneNumber});

  ResultVoid verifyOtp(
      {required String verificationId, required String otpCode});
  ResultVoid signOut();

  Stream<bool> isLoggedIn();
}
