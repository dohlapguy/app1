import 'package:app1/core/utils/typedef.dart';
import 'package:app1/domain/repository/phone_auth_repo.dart';
import 'package:app1/domain/usecases/usecase.dart';

class SignOutUsecase implements UseCase<void, NoParams> {
  final AuthRepo authRepo;

  SignOutUsecase({required this.authRepo});
  @override
  ResultVoid call(NoParams noParams) async {
    return await authRepo.signOut();
  }
}
