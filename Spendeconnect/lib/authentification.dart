import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/user.dart';

class AuthentificationService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser (User? user){
    return user !=null ? AppUser( uid: user.uid) : null;
  }
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map((user) => _userFromFirebaseUser(user));
  }

  Future signInWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential result =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!) ;
    }catch(exception){
      print (exception.toString());
      return null;
    }
  }

  Future registerInWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential result = 
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // todo store new user firestore
      return _userFromFirebaseUser(user!) ;
    }catch(exception){
      print (exception.toString());
      return null;
    }
  }

  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(exception){
      print (exception.toString());
      return null;
    }
  }

}