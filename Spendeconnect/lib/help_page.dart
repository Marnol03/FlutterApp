import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'authentification.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final AuthentificationService _auth = AuthentificationService();
  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Récupérer l'utilisateur actuellement connecté
      User? user = _auth.getCurrentUser();

      if (user != null) {
        // Récupérer les données de Firestore pour l'utilisateur actuel
        DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userSnapshot.exists) {
          // Mettre à jour l'état avec les données récupérées
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
          setState(() {
            username = userData['username'];
            email = userData['email'];
          });
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
    }
  }

  Future<List<DocumentSnapshot>> getCollectionData(
      String collectionName) async {
    List<DocumentSnapshot> documentList = [];

    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collectionName).get();

      documentList = querySnapshot.docs;
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
    }

    return documentList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 35),
            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/profil.png'),
            ),
            const SizedBox(height: 25),
            itemProfile('Username', username, CupertinoIcons.person),
            const SizedBox(height: 12),
            itemProfile('Email', email, CupertinoIcons.mail),
            const SizedBox(height: 25),

            const SizedBox(height: 25),
            ElevatedButton.icon(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person, color: Colors.white),
              label: const Text('logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: Colors.pink.withOpacity(.3),
            spreadRadius: 1,
            blurRadius: 12,
          )
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: const Icon(Icons.arrow_forward, color: Colors.green),
        tileColor: Colors.white,
      ),
    );
  }
}