import 'dart:io';

import 'package:bloc_api_firebase_auth/bloc/auth_bloc.dart';
import 'package:bloc_api_firebase_auth/screen/sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:img_picker/img_picker.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  File? _imageFile;
  final TextEditingController sginup_email = TextEditingController();
  final TextEditingController sginup_password = TextEditingController();
  final TextEditingController sginup_name = TextEditingController();
  final TextEditingController sginup_phonenumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161616),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Register',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Sign_In(),
            ));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Mieal")),
            );
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  //image upload
                  GestureDetector(
                    onTap: () {
                      openDialog(context);
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 88, 88),
                          shape: BoxShape.circle),
                      child: _imageFile == null
                          ? Icon(
                              Icons.person,
                              size: 50,
                              color: Color.fromARGB(255, 37, 36, 36),
                            )
                          : ClipOval(
                              child: Image.file(
                                _imageFile!,
                                // width: 120,s
                                // height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // name
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff262626),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: sginup_name,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: Color(0xff6D6D6D),
                          fontFamily: "DMSans",
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        // errorText: nameError,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Eamil
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff262626),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: sginup_email,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'E - Mail',
                        hintStyle: TextStyle(
                          color: Color(0xff6D6D6D),
                          fontFamily: "DMSans",
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // password
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff262626),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: sginup_password,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Color(0xff6D6D6D),
                          fontFamily: "DMSans",
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // phone number
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff262626),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: sginup_phonenumber,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: Color(0xff6D6D6D),
                          fontFamily: "DMSans",
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // submit
                  InkWell(
                    onTap: () {
                      Signup();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        "submit",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Signup() async {
    String user_name = sginup_name.text;
    String user_email = sginup_email.text;
    String user_password = sginup_password.text;
    String user_phone = sginup_phonenumber.text;
    String? imagePath = _imageFile?.path;

    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

    if (user_name.isEmpty || user_name.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Name must be between 1 and 10 characters.'),
      ));
    } else if (user_email.isEmpty || !emailRegex.hasMatch(user_email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Invalid email format.'),
      ));
    } else if (user_password.isEmpty ||
        user_password.length < 8 ||
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+={}\[\]|;:"<>,./?])')
            .hasMatch(user_password)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
            'Password must be 8 characters long and contain at least one uppercase letter, one digit, and one special character.'),
      ));
    } else if (user_phone.isEmpty || user_phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Enter your current phone number.'),
      ));
    } else {
      try {
        // Upload the image to Firebase Storage if an image is selected
        String? imageUrl;
        if (imagePath != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('user_images/${DateTime.now().toIso8601String()}');

          final file = File(imagePath);
          final uploadTask = storageRef.putFile(file);

          // Show upload progress
          uploadTask.snapshotEvents.listen((event) {
            double progress = event.bytesTransferred / event.totalBytes;
            print('Upload progress: ${progress * 100}%');
          });

          // Wait for the upload to complete
          final snapshot = await uploadTask.whenComplete(() {});
          imageUrl = await snapshot.ref.getDownloadURL();
          print('Image URL: $imageUrl');
        }

        BlocProvider.of<AuthBloc>(context).add(SignUpRequested(
          email: user_email,
          password: user_password,
          name: user_name,
          phone: user_phone,
          image: imageUrl!,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ));
      }
    }
  }

  Future<void> openDialog(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Image Source'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context,
                    await picker.pickImage(source: ImageSource.camera));
              },
              child: ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context,
                    await picker.pickImage(source: ImageSource.gallery));
              },
              child: ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
              ),
            ),
          ],
        );
      },
    );

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
      //    _uploadImage(); // Upload the picked image
    }
  }
}
