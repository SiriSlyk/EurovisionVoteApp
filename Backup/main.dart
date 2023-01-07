import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/favoritesPage/favoritesPage.dart';
import 'screens/groupPage/groupPage.dart';
import 'screens/homePage.dart';
import 'write_examples.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );

  //print(getYear(2022).toString());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //color: Colors.yellow,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            children: [
              HomePage(),
              GroupPage(),
              FavoritesPage(),
              WriteExample(),
            ],
          ),
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.groups_outlined),
              ),
              Tab(
                icon: Icon(Icons.favorite_outlined),
              ),
              Tab(
                icon: Icon(Icons.settings),
              )
            ],
            indicatorColor: Colors.transparent,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
