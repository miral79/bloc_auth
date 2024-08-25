import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseDatabase _database;

  UserRepository({FirebaseFirestore? firestore, FirebaseDatabase? database})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _database = database ?? FirebaseDatabase.instance;

  Future<void> saveUserData({
    required String uid,
    required String name,
    required String email,
    required String password,
    // required String picurl,
  }) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'email': email,
        'password': password,
      }).then((docRef) {
        print('User data added with ID: ${docRef.id}');
      }).catchError((error) {
        print('Failed to add user data: $error');
      });

      await _database.ref().child('users').child(uid).set({
        'name': name,
        'email': email,
        'password': password,
        // 'picurl': picurl,
      }).then((_) {
        print('User data saved successfully. == MB');
      }).catchError((error) {
        print('Failed to save user data: $error');
      });
    } catch (e) {
      throw e;
    }
  }
}
