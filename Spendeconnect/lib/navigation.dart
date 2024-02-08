import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/presentation/create_pub_page.dart';
import 'package:flutter/material.dart';
import 'package:myapp/presentation/help_page.dart';
import 'package:myapp/presentation/history_page.dart';
import 'package:myapp/home_page.dart';
import 'package:myapp/themes/dark_mode.dart';
import 'package:myapp/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';

void main()async {
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
  int _CurrentIndex = 0;

  setCurrentIndex(int index){
    setState(() {
      _CurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title:const [
            Text("Publications",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                )
            ),
            Text("create a new publication",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                )
            ),
            Text("Favorites",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                )
            ),
            Text("About me",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                )
            )
          ][_CurrentIndex]
        ),
        body: [
           HomePage(),
          const CreatePub(),
          const HistoryPage(),
           ProfilPage(),
        ][_CurrentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _CurrentIndex,
          onTap: (index) => setCurrentIndex(index),
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline_outlined),
              label: 'About me',
            )
          ],
        ),
      ),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}

