import 'package:eurovisionvoteapp/Languages/en_lang.dart';
import 'package:flutter/material.dart';

import '../../../themes/darkTheme.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBlueColor,
        title: Text(
          LangEn.favoritesPageTitle,
          style: pageTitleLigth,
        ),
      ),
    );
  }
}
