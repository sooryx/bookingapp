import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = credential.user?.uid;
      await createUserDocument(credential, username,
          password); // assuming you have a method createUserDocument
      return credential.user;
    } catch (e) {
      print("Error during signup: $e");
      return null;
    }
  }

  Future<void> createUserDocument(
    UserCredential? userCredential,
    String username,
    String password,
  ) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
        'username': username,
        'email': userCredential.user!.email,
        'password': password,
      });
      await fetchMyBookings(username,userCredential.user!.email.toString());
    }
  }

  Future<void> fetchMyBookings(String username, String emailid) async {
    User? user = FirebaseAuth.instance.currentUser;
    var userDoc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get();

    if (userDoc.exists) {
      // The document exists, and you can access its data
      var userData = userDoc.data();
      if (userData != null) {
        print('Username: ${userData['username']}');
        print('Email: ${userData['email']}');
        username = ' ${userData['username']}';
        emailid = ' ${userData['email']}';
      } else {
        // User does not exist
        print('User does not exist');
      }
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("some error occured");
    }
  }
}
