part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthVerified extends AuthState {
  final String verificationId;

  AuthVerified(this.verificationId);
}

class AuthAuthenticated extends AuthState {
  final String uid;
  AuthAuthenticated({required this.uid});
}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}
