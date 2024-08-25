import 'package:bloc/bloc.dart';
import 'package:bloc_api_firebase_auth/repo/repository.dart';
import 'package:bloc_api_firebase_auth/repo/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthBloc({required this.authRepository, required this.userRepository})
      : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<VerifyPhoneNumberRequested>(_onVerifyPhoneNumberRequested);
    on<SignInWithPhoneNumberRequested>(_onSignInWithPhoneNumberRequested);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUpwithEmailandPassword(
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        await userRepository.saveUserData(
          uid: user.uid,
          name: event.name,
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(uid: user.uid));
        print("MB");
      } else {
        emit(AuthError(error: 'Sign up failed.'));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInwithEmailandPassword(
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        emit(AuthAuthenticated(uid: user.uid));
      } else {
        emit(AuthError(error: 'Sign in failed.'));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInwithGoogle();

      if (user != null) {
        await userRepository.saveUserData(
          uid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          password: '',
        );
        emit(AuthAuthenticated(uid: user.uid));
      } else {
        emit(AuthError(error: 'Google sign in failed.'));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onVerifyPhoneNumberRequested(
    VerifyPhoneNumberRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          emit(AuthAuthenticated(uid: FirebaseAuth.instance.currentUser!.uid));
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthError(error: e.message ?? 'Verification failed.'));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(AuthVerified(verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          emit(AuthVerified(verificationId));
        },
      );
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onSignInWithPhoneNumberRequested(
    SignInWithPhoneNumberRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        emit(AuthAuthenticated(uid: userCredential.user!.uid));
      } else {
        emit(AuthError(error: 'Sign-in with phone number failed.'));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
