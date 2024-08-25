part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  SignUpRequested(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone});
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});
}

class SignInWithGoogleRequested extends AuthEvent {}

class VerifyPhoneNumberRequested extends AuthEvent {
  final String phoneNumber;

  VerifyPhoneNumberRequested(this.phoneNumber);
}

class SignInWithPhoneNumberRequested extends AuthEvent {
  final String verificationId;
  final String smsCode;

  SignInWithPhoneNumberRequested(this.verificationId, this.smsCode);
}

class SignOutRequested extends AuthEvent {}
