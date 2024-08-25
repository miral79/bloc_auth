import 'package:bloc_api_firebase_auth/bloc/auth_bloc.dart';
import 'package:bloc_api_firebase_auth/screen/forget_screen.dart';
import 'package:bloc_api_firebase_auth/screen/home_screen.dart';
import 'package:bloc_api_firebase_auth/screen/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({super.key});

  @override
  State<Sign_In> createState() => _Sign_In();
}

class _Sign_In extends State<Sign_In> {
  final TextEditingController login_email = TextEditingController();
  final TextEditingController login_passwoed = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double totalwidth = MediaQuery.of(context).size.width;
    double totalheight = MediaQuery.of(context).size.height;
    return Center(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(160, 1, 63, 75),
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home_screen()),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                ));
              }
            },
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Login titel
                    SizedBox(
                      height: totalheight * 0.07,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    // Email
                    Container(
                      alignment: Alignment.center,
                      width: totalwidth * 0.80,
                      height: totalheight * 0.10,
                      child: TextField(
                        controller: login_email,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2)),
                          prefixIcon:
                              Icon(Icons.email_rounded, color: Colors.black45),
                          filled: true,
                          fillColor: Colors.white60,
                          hintText: "Enter Email-Id",
                          // hintStyle: GoogleFonts.josefinSans(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 185, 199, 214),
                                  width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                        ),
                      ),
                    ),

                    // password
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      width: totalwidth * 0.80,
                      height: totalheight * 0.10,
                      child: TextField(
                        controller: login_passwoed,
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2)),
                          prefixIcon:
                              Icon(Icons.password, color: Colors.black45),
                          filled: true,
                          fillColor: Colors.white60,
                          hintText: "Enter Password",
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 185, 199, 214),
                                  width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                        ),
                      ),
                    ),

                    // Login
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () => login(),
                      child: Container(
                        alignment: Alignment.center,
                        width: totalwidth * 0.80,
                        height: 50,
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(159, 10, 121, 143),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),

                    // forget password
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return PhoneNumberScreen();
                          },
                        ));
                      },
                      child: Container(
                        width: totalwidth * 0.80,
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Foreget password",
                          style: TextStyle(
                            color: Color.fromARGB(255, 82, 100, 235),
                            fontSize: 15,
                            decorationColor: Color.fromARGB(255, 82, 100, 235),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),
                    // google atho
                    InkWell(
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(SignInWithGoogleRequested());
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(159, 10, 121, 143),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromARGB(255, 215, 213, 213),
                              width: 1,
                            ),
                          ),
                          width: totalwidth * 0.80,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Login with google",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                    ),

                    //Create account
                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        color: Colors.white24,
                        thickness: 1,
                      ),
                    ),

                    SizedBox(height: 20),
                    //Sign up
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Sign_up(),
                            ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: totalwidth * 0.80,
                        height: 50,
                        child: Text(
                          " Sign up",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(159, 10, 121, 143),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() {
    String user_login_email = login_email.text;
    String user_password = login_passwoed.text;
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

    if (user_login_email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please enter your email.'),
      ));
    } else if (!emailRegex.hasMatch(user_login_email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Invalid email format.'),
      ));
    } else if (user_password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please enter your password.'),
      ));
    } else {
      BlocProvider.of<AuthBloc>(context).add(SignInRequested(
        email: user_login_email,
        password: user_password,
      ));
    }
  }
}
