import 'package:flutter/material.dart';

import 'widgets/countryListPage.dart';

class GroupPage extends StatefulWidget {
  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool tileView = true;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return CountryList(); //tileView ? CountryList() : CountryDetail.useFirst(Entries(), 3);
  }
}
