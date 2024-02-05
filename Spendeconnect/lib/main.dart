import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:myapp/utils/user.dart';
import 'package:myapp/presentation/splaschscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/data/local_todo_data_source.dart';
import 'package:myapp/data/todo_data_source.dart';
import 'package:myapp/domain/todos/todo_repository.dart';



import 'services/authentification.dart';
import 'services/firebase_options.dart';


//import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return  StreamProvider<AppUser?>.value(
      value: AuthentificationService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('fr', 'FR'), // French
          // Add more locales as needed
        ],
        home: SplashScreenWrapper(),
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
      ),
    );
  }
}




