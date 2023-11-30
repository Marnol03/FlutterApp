import 'package:flutter/material.dart';
import 'package:myapp/authentification.dart';

class HomeScreen extends StatelessWidget {

  final AuthentificationService _auth = AuthentificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('welcome back 😊'),
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person,color: Colors.white,),
                label: Text('logout')
            ),
          ]
      ),
    );
  }
}
