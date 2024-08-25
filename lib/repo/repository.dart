import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<User?> signUpwithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth exceptions
      if (e.code == 'email-already-in-use') {
        throw 'The email address is already in use by another account.';
      } else if (e.code == 'weak-password') {
        throw 'The password is too weak.';
      } else if (e.code == 'invalid-email') {
        throw 'The email address is invalid.';
      } else {
        throw e.message ?? 'An unknown error occurred.';
      }
    } catch (e) {
      throw 'An unknown error occurred.';
    }
  }

  Future<User?> signInwithEmailandPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided.');
      } else {
        throw Exception('Sign in failed. Please try again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw Exception("Failed to sign in with Google: $e");
    }
  }

  Future<User?> signInwithPhone(
      String phonenumber,
      Function verificationCompleted,
      Function verdicationFailed,
      Function codesent,
      Function codeAutoRetrievalTimout) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (PhoneAuthCredential credebtial) async {
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credebtial);
        verificationCompleted(userCredential.user);
      },
      verificationFailed: (FirebaseAuthException e) {
        verdicationFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        codesent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        codeAutoRetrievalTimout(verificationId);
      },
    );
  }

  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
