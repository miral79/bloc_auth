import 'package:bloc_api_firebase_auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String verificationId;
  final TextEditingController _smsCodeController = TextEditingController();

  VerificationCodeScreen(this.verificationId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Verification Code'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            print("AuthAuthenticated state received");
            Navigator.of(context).popUntil((route) => route.isFirst);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Authentication successful!')),
            );
          } else if (state is AuthError) {
            print("AuthError state received: ${state.error}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _smsCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final smsCode = _smsCodeController.text.trim();
                  if (smsCode.isNotEmpty) {
                    context.read<AuthBloc>().add(
                          SignInWithPhoneNumberRequested(
                              verificationId, smsCode),
                        );
                  }
                },
                child: Text('Verify & Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
