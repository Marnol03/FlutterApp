import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/utils/constant.dart';
import 'package:myapp/services/authentification.dart';
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
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              elevation: 0.0,
              title: Center(
                child: Text(
                  showSignIn ? 'Log in' : 'Sign in',
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Poppins', fontSize: 30),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/spendephoto1.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                      showSignIn ? 'Welcome back,' : 'welcome to SpendeConnect',
                      style: TextStyle(
                          fontSize: showSignIn ? 40 : 30,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    child: Form(
                      key: _formkey,
                      child: (Column(
                        children: [
                          if (!showSignIn) ...[
                            TextFormField(
                              controller: usernameController,
                              decoration: textInputdecoration.copyWith(
                                hintText: "username",
                                labelText: 'Username',
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? "enter a username " : null,
                            ),
                          ] else
                            Container(),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: emailController,
                            decoration: textInputdecoration.copyWith(
                                hintText: "email", labelText: 'Email'),
                            validator: (value) =>
                                value!.isEmpty ? "enter a email" : null,
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: passwordController,
                            decoration: textInputdecoration.copyWith(
                                hintText: "Password"),
                            obscureText: true,
                            validator: (value) =>
                                value!.length < 6 ? "invalid password" : null,
                          ),
                          const SizedBox(height: 10.0),
                          TextButton.icon(
                            icon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            label: Text(
                                showSignIn
                                    ? 'You don`t have an Account? =>Sign in'
                                    : 'you already have an Account =>Log in',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.none)),
                            onPressed: () => toggleview(),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                            child: Text(
                              showSignIn ? "Log in" : "sign in",
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                //setState(() => loading = true);
                                var password = passwordController.value.text;
                                var email = emailController.value.text;
                                var username = usernameController.value.text;

                                dynamic result = showSignIn
                                    ? await _auth.signInWithEmailAndPassword(
                                        email, password)
                                    : await _auth
                                        .registerInWithEmailAndPassword(
                                            username, email, password);

                                if(!showSignIn){
                                  CollectionReference postRef = FirebaseFirestore
                                      .instance
                                      .collection("users");
                                  postRef.add({
                                    "email": email,
                                    "username": username,
                                  });
                                }

                                print("le result est : $result");
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        showSignIn? 'Email or password invalid':'enter valid informations';
                                  });
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 11.0),
                          Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 15),
                          )
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ));
  }
}
 