import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/phone_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final auth = FirebaseAuth.instance;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    // When user clicks on send otp button then this event will be fired
    on<SendOtpToPhoneEvent>(_onSendOtp);

    // After receiving the otp, When user clicks on verify otp button then this event will be fired
    on<VerifySentOtpEvent>(_onVerifyOtp);

    // When the firebase sends the code to the user's phone, this event will be fired
    on<OnPhoneOtpSent>((event, emit) =>
        emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId)));

    // When any error occurs while sending otp to the user's phone, this event will be fired
    on<OnPhoneAuthErrorEvent>(
        (event, emit) => emit(PhoneAuthError(error: event.error)));

    // When the otp verification is successful, this event will be fired
    on<OnPhoneAuthVerificationCompleteEvent>(_loginWithCredential);

    on<CheckAuthStatus>(_checkAuthState);

    on<AuthLogoutEvent>((event, emit) async {
      await authRepository.signOut();
      emit(AuthLogoutState());
    });
  }

  FutureOr<void> _onSendOtp(
      SendOtpToPhoneEvent event, Emitter<AuthState> emit) async {
    emit(PhoneAuthLoading());
    try {
      await authRepository.verifyPhone(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // On [verificationComplete], we will get the credential from the firebase  and will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
          add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
        },
        codeSent: (String verificationId, int? resendToken) {
          // On [codeSent], we will get the verificationId and the resendToken from the firebase and will send it to the [OnPhoneOtpSent] event to be handled by the bloc and then will emit the [OnPhoneAuthVerificationCompleteEvent] event after receiving the code from the user's phone
          add(OnPhoneOtpSent(
              verificationId: verificationId, token: resendToken));
        },
        verificationFailed: (FirebaseAuthException e) {
          // On [verificationFailed], we will get the exception from the firebase and will send it to the [OnPhoneAuthErrorEvent] event to be handled by the bloc and then will emit the [PhoneAuthError] state in order to display the error to the user's screen
          add(OnPhoneAuthErrorEvent(error: e.code));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }

  FutureOr<void> _onVerifyOtp(
      VerifySentOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(PhoneAuthLoading());
      // After receiving the otp, we will verify the otp and then will create a credential from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode,
      );
      add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }

  FutureOr<void> _loginWithCredential(
      OnPhoneAuthVerificationCompleteEvent event,
      Emitter<AuthState> emit) async {
    // After receiving the credential from the event, we will login with the credential and then will emit the [PhoneAuthVerified] state after successful login
    try {
      await auth.signInWithCredential(event.credential).then((user) {
        if (user.user != null) {
          emit(PhoneAuthVerified());
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(PhoneAuthError(error: e.code));
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _checkAuthState(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    try {
      final isLoggedIn = await authRepository.isLoggedIn();
      if (isLoggedIn) {
        print('Loggin');
        emit(AuthLoggedInState());
      } else {
        print('Logout');
        emit(AuthLogoutState());
      }
    } catch (e) {
      // Handle any errors
      emit(AuthLogoutState());
    }
  }
}
