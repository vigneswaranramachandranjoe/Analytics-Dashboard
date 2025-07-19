import 'package:firebase_auth/firebase_auth.dart';

class UserLoginModel {
  final String uid;
  final String email;

  UserLoginModel({required this.uid, required this.email});

  factory UserLoginModel.fromFirebaseUser(User user) {
    return UserLoginModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }
}
