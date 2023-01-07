import 'package:eurovisionvoteapp/Languages/en_lang.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../services/firebaseservice.dart';
import '../../../themes/darkTheme.dart';
import '../../login/view/login_page.dart';

final user = FirebaseAuth.instance.currentUser;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: darkBlueColor,
          title: Text(LangEn.profilePageTitle),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                FirebaseService service = new FirebaseService();
                await service.signOutFromGoogle();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Signin()));
                /*Navigator.pushReplacementNamed(
                    context, Constants.signInNavigate);*/
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text(user!.email!),
              Text(user!.uid),
              Text(user!.displayName!),
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 20,
              ),
            ],
          ),
        ));
  }
}
