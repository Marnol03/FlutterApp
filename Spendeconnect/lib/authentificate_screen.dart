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

  final emailController= TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleview(){
    setState(() {
      _formkey.currentState?.reset();
      error ='';
      emailController.text='';
      passwordController.text='';
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title: Text(
          showSignIn ? 'Sign in ': 'Register',
        ),
        actions:<Widget> [
          TextButton.icon(
            icon: Icon(Icons.person,
              color: Colors.white,
            ),
            label: Text(showSignIn ? 'Register in' : 'Sign in',
                style: TextStyle(color: Colors.white)),
            onPressed: () => toggleview(),
          )
        ],
      ),body: Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      child: Form(
        key: _formkey,
        child: (
            Column(
              children: [
                TextFormField (
                  controller: emailController,
                  decoration: textInputdecoration.copyWith(hintText: "entrez votre email"),
                  validator: (value) => value!.isEmpty? "entrez votre email" : null,
                ),
                SizedBox(height: 10.0),
                TextFormField (
                  controller: passwordController,
                  decoration: textInputdecoration.copyWith(hintText: "entrez votre mot de passe"),
                  obscureText: true,
                  validator: (value) =>
                  value!.length < 6 ? "entrez un mot de passe valide" : null,
                ),
                SizedBox(height:10.0),
                ElevatedButton(
                  child: Text(
                    showSignIn ? "sign In" : "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formkey.currentState!.validate()){
                      setState(() => loading = true);
                      var password = passwordController.value.text;
                      var email = emailController.value.text;

                      dynamic result = showSignIn ? await _auth.signInWithEmailAndPassword(email, password):
                          await _auth.registerInWithEmailAndPassword(email, password);

                      if(result == null ){
                        setState(() {
                          loading = false;
                          error = 'entrez une adresse mail valide svp';
                        });
                      }
                    }
                  },
                ),
                SizedBox(height:10.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red,fontSize: 15),
                )
              ],
            )
        ),
      ),
    ),

    );
  }
}