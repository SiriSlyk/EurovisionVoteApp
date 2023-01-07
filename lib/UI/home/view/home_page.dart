import 'package:eurovisionvoteapp/Languages/en_lang.dart';
import 'package:eurovisionvoteapp/themes/darkTheme.dart';
import 'package:flutter/material.dart';

import '../../../services/firebaseservice.dart';
import '../../login/view/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBlueColor,
        title: Text(LangEn.homePageTitle),
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
      //body: HorizontalListJumboDemo(),
    );
  }
}
