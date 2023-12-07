import 'package:app1/core/error/failure.dart';

class InvalidPhoneNumberFailure extends Failure {
  const InvalidPhoneNumberFailure();
}

class TooManyRequestFailure extends Failure {
  const TooManyRequestFailure();
}

class SmsTimeOutFailure extends Failure {
  const SmsTimeOutFailure();
}

class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure();
}

class InvalidVerificationCodeFailure extends Failure {
  const InvalidVerificationCodeFailure();
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure();
}

String getStringByAuthFailure(Failure authFailure) {
  if (authFailure is InvalidPhoneNumberFailure) {
    return "Invalid Phone Number";
  } else if (authFailure is TooManyRequestFailure) {
    return "Too many Request";
  } else if (authFailure is SmsTimeOutFailure) {
    return "Time out";
  } else if (authFailure is SessionExpiredFailure) {
    return "Session Expired";
  } else if (authFailure is InvalidVerificationCodeFailure) {
    return "Invalid Verification code";
  } else if (authFailure is UserNotFoundFailure) {
    return "User not found";
  } else {
    return "Unexpected Error";
  }
}
