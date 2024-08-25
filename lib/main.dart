import 'package:bloc_api_firebase_auth/bloc/auth_bloc.dart';
import 'package:bloc_api_firebase_auth/repo/repository.dart';
import 'package:bloc_api_firebase_auth/repo/user_repository.dart';
import 'package:bloc_api_firebase_auth/screen/sign_in.dart';
import 'package:bloc_api_firebase_auth/screen/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final fcmService = FCMService();
  // await fcmService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: AuthRepository(),
        userRepository: UserRepository(),
      ),
      child: MaterialApp(
        home: const Sign_In(),
      ),
    );
  }
}
