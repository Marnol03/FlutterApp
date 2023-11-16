import 'package:flutter/material.dart';
import 'package:myapp/authentification.dart';

class ProfilPage extends StatefulWidget {
   const ProfilPage({super.key});



  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  final AuthentificationService _auth = AuthentificationService();

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "the user is going to see informations about him hier",
            style: TextStyle(
              fontSize: 34,
              fontFamily: 'Poppins',
            ),
          ),
          ElevatedButton.icon(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person,color: Colors.white,),
              label: Text('logout')
          ),
        ],
      ),
    );
  }
}
