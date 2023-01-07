import 'package:flutter/material.dart';

import '../UI/index/view/index_page.dart';
import '../UI/login/view/login_page.dart';
import '../UI/welcome/view/welcomePage.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => WelcomePage(),
    '/sign-in': (context) => Signin(),
    '/home': (context) => IndexPage()
  };
}
