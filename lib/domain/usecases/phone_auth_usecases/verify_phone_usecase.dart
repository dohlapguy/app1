
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/domain/repository/phone_auth_repo.dart';
import 'package:equatable/equatable.dart';

import 'package:app1/domain/usecases/usecase.dart';

import '../../../core/utils/typedef.dart';

class VerifyPhoneUsecase implements UseCase<String, VerifyPhoneParams> {
  final AuthRepo authRepo;

  VerifyPhoneUsecase({required this.authRepo});

  @override
  ResultFuture<String> call(VerifyPhoneParams params) async {
    return await authRepo.verifyPhone(phoneNumber: params.phoneNumber);
  }
}

class VerifyPhoneParams extends Equatable {
  final String phoneNumber;

  const VerifyPhoneParams({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}
