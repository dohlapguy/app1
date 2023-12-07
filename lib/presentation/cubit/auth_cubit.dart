import 'dart:async';

import 'package:app1/core/error/auth_failure.dart';
import 'package:app1/domain/repository/phone_auth_repo.dart';
import 'package:app1/domain/usecases/auth_usecases/is_logged_in_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failure.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsLoggedInUsecase isLoggedInUsecase;
  late StreamSubscription<bool> _authIsLoggedInSubscription;

  AuthCubit({required this.isLoggedInUsecase}) : super(AuthInitial()) {
    _authIsLoggedInSubscription = isLoggedInUsecase().listen((isLoggedIn) {
      isLoggedIn ? emit(AuthIsLoggedInState()) : emit(AuthIsLoggedOutState());
    });
  }
  @override
  Future<void> close() async {
    await _authIsLoggedInSubscription.cancel();
    super.close();
  }
}
