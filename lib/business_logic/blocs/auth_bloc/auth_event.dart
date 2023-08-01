part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// This event will be triggered when the user enters the phone number and presses the Send OTP button on the UI.
class SendOtpToPhoneEvent extends AuthEvent {
  final String phoneNumber;

  const SendOtpToPhoneEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

// This event will be triggered when the user enters the OTP and presses the Verify OTP button on the UI.
class VerifySentOtpEvent extends AuthEvent {
  final String otpCode;
  final String verificationId;

  const VerifySentOtpEvent(
      {required this.otpCode, required this.verificationId});

  @override
  List<Object> get props => [otpCode, verificationId];
}

// This event will be triggered when firebase sends the OTP to the user's phone number.
class OnPhoneOtpSent extends AuthEvent {
  final String verificationId;
  final int? token;
  const OnPhoneOtpSent({
    required this.verificationId,
    required this.token,
  });

  @override
  List<Object> get props => [verificationId];
}

// This event will be triggered when any error occurs while sending the OTP to the user's phone number. This can be due to network issues or firebase's error.
class OnPhoneAuthErrorEvent extends AuthEvent {
  final String error;
  const OnPhoneAuthErrorEvent({required this.error});

  @override
  List<Object> get props => [error];
}

// This event will be triggered when the verification of the OTP is successful.
class OnPhoneAuthVerificationCompleteEvent extends AuthEvent {
  final AuthCredential credential;
  const OnPhoneAuthVerificationCompleteEvent({
    required this.credential,
  });
}

class AuthLogoutEvent extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}
