import 'dart:async';

import 'package:app1/core/error/auth_failure.dart';
import 'package:app1/domain/usecases/phone_auth_usecases/sign_out_usecase.dart';
import 'package:app1/domain/usecases/phone_auth_usecases/verify_otp_usecase.dart';
import 'package:app1/domain/usecases/phone_auth_usecases/verify_phone_usecase.dart';
import 'package:app1/domain/usecases/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneLoginAuthBloc extends Bloc<PhoneLoginAuthEvent, PhoneAuthState> {
  final VerifyPhoneUsecase verifyPhoneUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final SignOutUsecase signOutUsecase;
  final auth = FirebaseAuth.instance;
  PhoneLoginAuthBloc(
      {required this.verifyPhoneUsecase,
      required this.verifyOtpUsecase,
      required this.signOutUsecase})
      : super(PhoneAuthInitial()) {
    on<SendOtpToPhoneEvent>(_sendOtp);

    on<VerifySentOtpEvent>(_onVerifyOtp);

    on<OnPhoneOtpSent>((event, emit) =>
        emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId)));

    on<OnPhoneAuthErrorEvent>(
        (event, emit) => emit(PhoneAuthError(error: event.error)));

    // on<CheckAuthStatus>(_checkAuthState);

    // on<OnPhoneAuthVerificationCompleteEvent>(_loginWithCredential);

    on<AuthLogoutEvent>((event, emit) async {
      final failureOrSignOut = await signOutUsecase.call(NoParams());
      failureOrSignOut.fold(
          (failure) =>
              emit(PhoneAuthError(error: getStringByAuthFailure(failure))),
          (r) => emit(AuthLogoutState()));
    });
  }

  FutureOr<void> _sendOtp(
      SendOtpToPhoneEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());

    final failureOrVerficationId = await verifyPhoneUsecase
        .call(VerifyPhoneParams(phoneNumber: event.phoneNumber));

    failureOrVerficationId.fold(
        (failure) =>
            emit(PhoneAuthError(error: getStringByAuthFailure(failure))),
        (verificationId) =>
            add(OnPhoneOtpSent(verificationId: verificationId)));
  }

  FutureOr<void> _onVerifyOtp(
      VerifySentOtpEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());

    final failureOrVerified = await verifyOtpUsecase.call(VerifyOtpParams(
        verificationId: event.verificationId, otp: event.otpCode));

    failureOrVerified.fold(
        (failure) =>
            emit(PhoneAuthError(error: getStringByAuthFailure(failure))),
        (r) => emit(PhoneAuthVerified()));
  }

  // FutureOr<void> _loginWithCredential(
  //     OnPhoneAuthVerificationCompleteEvent event,
  //     Emitter<AuthState> emit) async {
  //   // After receiving the credential from the event, we will login with the credential and then will emit the [PhoneAuthVerified] state after successful login
  //   try {
  //     await auth.signInWithCredential(event.credential).then((user) {
  //       if (user.user != null) {
  //         emit(PhoneAuthVerified());
  //       }
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     emit(PhoneAuthError(error: e.code));
  //   } catch (e) {
  //     emit(PhoneAuthError(error: e.toString()));
  //   }
  // }

  // Future<FutureOr<void>> _checkAuthState(
  //     CheckAuthStatus event, Emitter<AuthState> emit) async {
  //   try {
  //     final isLoggedIn = await authRepository.isLoggedIn();
  //     if (isLoggedIn) {
  //       print('Loggin');
  //       emit(AuthLoggedInState());
  //     } else {
  //       print('Logout');
  //       emit(AuthLogoutState());
  //     }
  //   } catch (e) {
  //     // Handle any errors
  //     emit(AuthLogoutState());
  //   }
  // }
}
