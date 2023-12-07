import 'package:app1/core/error/failure.dart';
import 'package:app1/domain/repository/phone_auth_repo.dart';

import 'package:dartz/dartz.dart';

class IsLoggedInUsecase {
  final AuthRepo authRepo;

  IsLoggedInUsecase({required this.authRepo});

  Stream<bool> call() {
    return authRepo.isLoggedIn();
  }
}
