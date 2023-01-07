import 'package:eurovisionvoteapp/Languages/en_lang.dart';
import 'package:flutter/material.dart';
import '../../../themes/darkTheme.dart';
import '../widgets/groups-boxes.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: Text(LangEn.groupsPageTitle),
      ),
      body: GroupBoxes(),
    );
  }
}
