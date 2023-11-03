import 'package:flutter/material.dart';
import 'package:myapp/create_pub_page.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  void btnClick() {
    print('Bouton cliqué');
  }

  @override
  Widget build(BuildContext context) {
    return const  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ici se trouveront des moyens de contacter le support",
            style: TextStyle(
              fontSize: 38,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
