import 'package:flutter/material.dart';
import 'package:myapp/home_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/presentation/authentificate_screen.dart';
import 'package:myapp/presentation/home_screen.dart';
import 'package:myapp/utils/user.dart';
import 'package:myapp/navigation.dart';

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if(user== null ){
      return AuthentificateScreen();
    }else{
      return MyApp();
    }
  }
}
