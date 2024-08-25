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
    required String phone,
    required String image,
  }) async {
    try {
      // Save to Firestore
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'image': image,
      }).then((_) {
        print('User data added with ID: $uid');
      }).catchError((error) {
        print('Failed to add user data: $error');
      });

      await _database.ref().child('users').child(uid).set({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'image': image,
      }).then((_) {
        print('User data saved successfully. == MB');
      }).catchError((error) {
        print('Failed to save user data: $error');
      });
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
