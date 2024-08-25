import 'package:bloc_api_firebase_auth/bloc/auth_bloc.dart';
import 'package:bloc_api_firebase_auth/screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({
    super.key,
  });

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: () {
            BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Sign_In();
              },
            ));
          },
          child: Container(
            height: 100,
            width: 500,
            color: Colors.white,
            child: Center(
              child: Text(
                "Signe Out",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
