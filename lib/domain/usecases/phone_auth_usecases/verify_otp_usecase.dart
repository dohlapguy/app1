
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/core/error/failure.dart';
import 'package:app1/domain/repository/phone_auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:app1/domain/usecases/usecase.dart';

import '../../../core/utils/typedef.dart';

class VerifyOtpUsecase implements UseCase<void, VerifyOtpParams> {
  final AuthRepo authRepo;

  VerifyOtpUsecase({required this.authRepo});

  @override
  ResultVoid call(VerifyOtpParams params) async {
    return await authRepo.verifyOtp(
        verificationId: params.verificationId, otpCode: params.otp);
  }
}

class VerifyOtpParams extends Equatable {
  final String verificationId;
  final String otp;

  const VerifyOtpParams({required this.verificationId, required this.otp});

  @override
  List<Object> get props => [verificationId, otp];
}
