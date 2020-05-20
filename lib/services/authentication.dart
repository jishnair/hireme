import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hireme/models/User.dart';

abstract class BaseAuth {
  Future<User> signIn(String email, String password);

  Future<User> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class AuthService implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //create user obj based on FirebaseUser

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get userStream {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future<User> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser firebaseUser = result.user;
    return _userFromFirebaseUser(firebaseUser);
  }

  Future<User> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser firebaseUser = result.user;
    return  _userFromFirebaseUser(firebaseUser);
  }

  Future<User> getCurrentUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    return  _userFromFirebaseUser(firebaseUser);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}