import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/support_page.dart';

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
    // Fetch user data when the widget is initialized
    fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      // Get the currently signed-in user
      User? user = _auth.getCurrentUser();

      if (user != null) {
        // Retrieve Firestore data for the current user
        DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userSnapshot.exists) {
          // Update state with the retrieved data
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
          setState(() {
            username = userData['username'];
            email = userData['email'];
          });
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  // Fetch data from a Firestore collection
  Future<List<DocumentSnapshot>> getCollectionData(String collectionName) async {
    List<DocumentSnapshot> documentList = [];

    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collectionName).get();

      documentList = querySnapshot.docs;
    } catch (e) {
      print("Error fetching data: $e");
    }

    return documentList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 35),
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/profil.png'),
              ),
              const SizedBox(height: 25),
              // Display user profile information
              itemProfile('Username', username, CupertinoIcons.person),
              const SizedBox(height: 12),
              itemProfile('Email', email, CupertinoIcons.mail),
              const SizedBox(height: 25),
              Image.asset(
                'assets/images/spendeconnect1.jpg',
              ),
              const SizedBox(height: 25),
              // Logout button
              ElevatedButton.icon(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                ),
                onPressed: () async {
                  // Perform sign out action
                  await _auth.signOut();
                },
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
      // Floating action button for support
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // Action to perform when the floating action button is clicked
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => SupportPage(username: username, email: email),
            ),
          );
        },
        tooltip: 'Support',
        child: Icon(Icons.support_agent),
      ),
    );

  }

  // Widget to display profile information
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
