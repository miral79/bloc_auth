import 'package:bloc_api_firebase_auth/bloc/auth_bloc.dart';
import 'package:bloc_api_firebase_auth/screen/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  String? _completePhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Phone Number'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthVerified) {
            print("AuthVerified state received: ${state.verificationId}");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    VerificationCodeScreen(state.verificationId),
              ),
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
              IntlPhoneField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                initialCountryCode: 'US',
                onChanged: (phone) {
                  _completePhoneNumber = phone.completeNumber;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("Phone number: $_completePhoneNumber");
                  if (_completePhoneNumber != null &&
                      _completePhoneNumber!.isNotEmpty) {
                    context.read<AuthBloc>().add(
                          VerifyPhoneNumberRequested(_completePhoneNumber!),
                        );
                  }
                },
                child: Text('Send Verification Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
