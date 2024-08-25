import 'package:bloc_api_firebase_auth/bloc/auth_bloc.dart';
import 'package:bloc_api_firebase_auth/repo/user_repository.dart';
import 'package:bloc_api_firebase_auth/screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  late UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository(); // Initialize UserRepository
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Sign_In()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              final uid = state.uid;

              return FutureBuilder<Map<String, dynamic>?>(
                future: _userRepository.getUserData(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No data found'));
                  } else {
                    final userData = snapshot.data!;
                    final imageUrl = userData['image'];

                    print(imageUrl);

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (imageUrl != null)
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(imageUrl),
                            )
                          else
                            CircleAvatar(
                              radius: 50,
                              child: Icon(Icons.person, size: 50),
                            ),
                          SizedBox(height: 20),
                          // Text('Name: ${userData['name']}'),
                          Text('Email: ${userData['email']}'),
                          // Text(
                          //     'Phone: ${userData['phone']}'), // Adjust based on your data
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignOutRequested());
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Sign_In(),
                                ),
                              );
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.40,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Sign Out",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            } else if (state is AuthError) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return Center(child: Text('User not authenticated'));
            }
          },
        ),
      ),
    );
  }
}
