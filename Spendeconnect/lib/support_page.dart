import 'package:flutter/material.dart';

import 'package:flutter_tawk/flutter_tawk.dart';

void main() => runApp(const MaterialApp(
  home: SupportPage(username: '', email: ''),
));


class SupportPage extends StatelessWidget {
  final String username;
  final String email;
  const SupportPage({Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Spendeconnect Support',
          style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0XFFF7931E),
          elevation: 0,
        ),
        body: Tawk(
          directChatLink: 'https://tawk.to/chat/6568b890bfb79148e59892f9/1hggh1t7r',
          visitor: TawkVisitor(
            name: username,
            email: email,
          ),
          onLoad: () {
            print('Hello Tawk! Username: $username, Email: $email');
          },
          onLinkTap: (String url) {
            print('Link tapped: $url');
            print('Username: $username, Email: $email');
          },

          placeholder: const Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}