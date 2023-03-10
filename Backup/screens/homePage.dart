import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/firebaseservice.dart';
import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              FirebaseService service = new FirebaseService();
              await service.signOutFromGoogle();
              Navigator.pushReplacementNamed(context, Constants.signInNavigate);
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user!.email!),
            Text(user!.displayName!),
            CircleAvatar(
              backgroundImage: NetworkImage(user!.photoURL!),
              radius: 20,
            )
          ],
        ),
      ),
    );
  }
}
