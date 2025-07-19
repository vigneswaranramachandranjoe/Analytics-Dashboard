import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_dashboard/LOGIN/model/login_model.dart';

class LoginRepository {
  final FirebaseAuth _firebaseAuth;

  LoginRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserLoginModel> logIn({required String email, required String password}) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    print(result);


    return UserLoginModel.fromFirebaseUser(result.user!);
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get user => _firebaseAuth.authStateChanges();
}
