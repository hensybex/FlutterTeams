import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:black_pearl/tools/user_model.dart';

class AuthService {
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

  User? userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return firebaseAuth.authStateChanges().map(userFromFirebase);
  }

  Future<User?> signInWithEmailAndPass(
    String email,
    String password,
  ) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userFromFirebase(credential.user);
  }

  Future<User?> createUserWithEmailAndPass(
    String email,
    String password,
  ) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }
}
