import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/user.dart';

class AuthentificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map((user) => _userFromFirebaseUser(user));
  }

  Future<AppUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Error when connecting : $e");
      return null;
    }
  }

  Future<AppUser?> registerInWithEmailAndPassword(String username, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // todo store new user firestore
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Erreur lors de l'inscription : $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Erreur lors de la déconnexion : $e");
    }
  }
}
