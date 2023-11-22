import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/authentification.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfilPage extends StatefulWidget {
   const ProfilPage({super.key});



  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  final AuthentificationService _auth = AuthentificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 35),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/daniella.jpeg'),
            ),
            const SizedBox(height: 25),
            itemProfile('Username', 'Daniella', CupertinoIcons.person),
            const SizedBox(height: 12),
            itemProfile('Email', 'email', CupertinoIcons.mail),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(13),
                    backgroundColor: Colors.lightGreen,
                  ),
                  child: const Text('Edit Profile')
              ),
            ),
            const SizedBox(height: 25),
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
      ),
    );
  }

  itemProfile(String title, String subtitle,IconData iconData){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,4),
              color:Colors.pink.withOpacity(.3),
              spreadRadius: 1,
              blurRadius: 12,

            )
          ]
      ),
      child: ListTile(
        title:  Text(title),
        subtitle:  Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward,color: Colors.green),
        tileColor: Colors.white,
      ),
    );
  }
}












/* Center(
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
    );*/