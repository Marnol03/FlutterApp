import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String? uid;
  final String? username;
  final String? email;

  AppUser({this.uid, this.username, this.email});

  factory AppUser.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return AppUser(
      uid: document.id,
      username: data['username'] as String?,
      email: data['email'] as String?,
    );
  }
}
