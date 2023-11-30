import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/user.dart';

class AuthentificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Convert Firebase User to custom AppUser
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // Stream to listen for authentication state changes
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map((user) => _userFromFirebaseUser(user));
  }

  // Function to sign in with email and password
  Future<AppUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in with email and password
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Retrieve user data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

      if (userSnapshot.exists) {
        // User data successfully retrieved from Firestore
        AppUser appUser = AppUser.fromFirestore(userSnapshot);
        return appUser;
      } else {
        // User has no data in Firestore
        print("No Firestore data found for the user with ID: ${user?.uid}");
        return null;
      }
    } catch (exception) {
      // An error occurred during authentication or retrieving Firestore data
      print("Error during login: $exception");
      return null;
    }
  }

  // Function to register a new user with email, username, and password
  Future registerInWithEmailAndPassword(String username, String email, String password) async {
    try {
      // Create a new user with email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Add user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'username': username,
        'email': email,
      });

      // Retrieve user data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
      AppUser appUser = AppUser.fromFirestore(userSnapshot);

      // Return the AppUser object
      return appUser;
    } catch (exception) {
      // Handle registration errors
      print(exception.toString());
      return null;
    }
  }

  // Function to sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      // Handle sign-out errors
      print(exception.toString());
      return null;
    }
  }

  // Function to get the current authenticated user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
