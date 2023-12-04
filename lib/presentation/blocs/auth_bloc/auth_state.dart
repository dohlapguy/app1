part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

// This state is used to show the loading indicator when the phone number is being sent to the server for verification and the user is being redirected to the verification page.
class PhoneAuthLoading extends AuthState {}

// This state is used to show the error message.
class PhoneAuthError extends AuthState {
  final String error;

  const PhoneAuthError({required this.error});

  @override
  List<Object> get props => [error];
}

// This state indicates that verification is completed and the user is being redirected to the home page.

// This state is used to show the OTP widget in which the user enters the OTP sent to his/her phone number.
class PhoneAuthCodeSentSuccess extends AuthState {
  final String verificationId;
  const PhoneAuthCodeSentSuccess({
    required this.verificationId,
  });
  @override
  List<Object> get props => [verificationId];
}

class PhoneAuthVerified extends AuthState {}

class AuthLoggedInState extends AuthState {}

class AuthLogoutState extends AuthState {}
