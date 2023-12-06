import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constant.dart';
import 'package:myapp/authentification.dart';
import 'loading.dart';

class AuthentificateScreen extends StatefulWidget {
  const AuthentificateScreen({super.key});

  @override
  State<AuthentificateScreen> createState() => _AuthentificateScreenState();
}

class _AuthentificateScreenState extends State<AuthentificateScreen> {
  final AuthentificationService _auth = AuthentificationService();
  final _formkey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleview() {
    setState(() {
      _formkey.currentState?.reset();
      error = '';
      usernameController.text = '';
      emailController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title: Text(
          showSignIn ? 'Sign in ' : 'Register',
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              showSignIn ? 'Register in' : 'Sign in',
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () => toggleview(),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              // Add the welcome message here
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child:  const Text(
                  'Welcome to SpendeConnect!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              if (!showSignIn) ...[
                Image.asset(
                  'assets/images/spendeconnect0.jpg',
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: usernameController,
                  decoration:
                  textInputdecoration.copyWith(hintText: "Enter your username"),
                  validator: (value) =>
                  value!.isEmpty ? "Enter your username" : null,
                ),
              ] else
                Container(),
              SizedBox(height: 10.0),
              TextFormField(
                controller: emailController,
                decoration: textInputdecoration.copyWith(hintText: "Enter your email"),
                validator: (value) => value!.isEmpty ? "Enter your email" : null,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                decoration:
                textInputdecoration.copyWith(hintText: "Enter your password"),
                obscureText: true,
                validator: (value) =>
                value!.length < 6 ? "Enter a valid password" : null,
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text(
                  showSignIn ? "Sign In" : "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() => loading = true);
                    var password = passwordController.value.text;
                    var email = emailController.value.text;
                    var username = usernameController.value.text;

                    dynamic result = showSignIn
                        ? await _auth.signInWithEmailAndPassword(email, password)
                        : await _auth.registerInWithEmailAndPassword(
                        username, email, password);

                    CollectionReference postRef =
                    FirebaseFirestore.instance.collection("users");
                    postRef.add({
                      "email": email,
                      "username": username,
                    });

                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'Enter a valid email address';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 10.0),

              if (!showSignIn) ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'Welcome to SpendeConnect, the platform that transforms your generosity into concrete actions to save lives.\n\n'
                        'Here, every gesture counts, every donation makes a difference. Imagine a place where solidarity comes to life, where your generosity turns into hope for those who need it most.\n\n'
                        'At SpendeConnect, we work together to create a positive impact in the world. Log in now to discover a universe dedicated to humanity, where every click can change a destiny.\n\n'
                        'Explore our different causes, from local initiatives to global projects. Make a donation, no matter how small, and witness the power of the united community to bring about meaningful changes.\n\n'
                        'Join us in this adventure where compassion becomes a driving force. Log in, make donations, and together, let\'s save lives. Because at SpendeConnect, solidarity is not just a concept, it\'s a tangible reality.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/spendeconnect2.jpg',
                ),
              ],

              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
