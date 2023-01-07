import 'package:flutter/material.dart';

import '../screens/homePage.dart';
import '../screens/signInPage.dart';
import '../screens/welcomePage.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => WelcomePage(),
    '/sign-in': (context) => SignInPage(),
    '/home': (context) => HomePage()
  };
}
