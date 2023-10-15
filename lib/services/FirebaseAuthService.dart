import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _loggedIn = false;
  bool isLoggedIn()=> _loggedIn;

  User? _user = null;
  User? getUser()=> _user;

  // sign in with email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      _user = userCredential.user;
      _loggedIn = true;
      return _user!;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in with email and password: $e');
      throw e;
    }
  }

  // create a new user with email and password
  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _user = result.user!;
    _loggedIn = true;
    await _addUser(_user!.uid);
    return _user!;
  }

  // sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _loggedIn = false;
    _user = null;
  }

  Future<void> _addUser(String id) async {
    Map<String, String> doc = {
      'name': 'none',
      'description': 'none'
    };
    await _firestore.collection('users').doc(id).set(doc);
  }
}