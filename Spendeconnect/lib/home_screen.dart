import 'package:flutter/material.dart';
import 'package:myapp/authentification.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/create_pub_page.dart';
import 'package:flutter/material.dart';
import 'package:myapp/help_page.dart';
import 'package:myapp/history_page.dart';
import 'package:myapp/home_page.dart';
import 'package:myapp/themes/dark_mode.dart';
import 'package:myapp/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
