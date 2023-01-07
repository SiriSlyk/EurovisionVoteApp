import 'package:eurovisionvoteapp/UI/index/view/index_page.dart';
import 'package:flutter/material.dart';
import '../../../themes/darkTheme.dart';
import '../widgets/countryListPage.dart';

class EntriesPage extends StatefulWidget {
  const EntriesPage({Key? key}) : super(key: key);

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios_new,
                color: blackColor, size: iconSize),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => IndexPage()));
            },
          ),
          title: const Text(
            'Dummy group',
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.poll_outlined,
                        size: iconSize, color: Colors.black))),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                    onTap: () {
                      print("getManageGroup()");
                    },
                    child: const Icon(Icons.manage_accounts_outlined,
                        size: iconSize, color: Colors.black))),
          ]),
      body: CountryList(),
    );
  }
}
