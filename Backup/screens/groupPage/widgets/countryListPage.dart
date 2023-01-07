import 'package:eurovisionvoteapp/themes/darkTheme.dart';

import 'package:flutter/material.dart';

import 'displayEntries.dart';

class CountryList extends StatefulWidget {
  @override
  State<CountryList> createState() => _CountryList();
}

class _CountryList extends State<CountryList> {
  var alignment = Alignment.center;
  var listTypeInt =
      CountryDisplay(3); //1 for first, 2 for second, 3 for grand final

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          title: const Text(
            'Group name',
            style: TextStyle(fontSize: 32, color: Colors.black),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.poll_outlined,
                        size: 26, color: Colors.black))),
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                    onTap: () {
                      print("getManageGroup()");
                    },
                    child: const Icon(
                      Icons.manage_accounts_outlined,
                      color: Colors.black,
                    )))
          ]),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Text('First semi'),
                onPressed: () {
                  setState(() {
                    listTypeInt = CountryDisplay(1);
                    alignment = Alignment.centerLeft;
                  });
                },
              ),
              TextButton(
                child: Text('Grand final'),
                onPressed: () {
                  setState(() {
                    listTypeInt = CountryDisplay(3);
                    alignment = Alignment.center;
                  });
                },
              ),
              TextButton(
                child: Text('Second semi'),
                onPressed: () {
                  setState(() {
                    listTypeInt = CountryDisplay(2);
                    alignment = Alignment.centerRight;
                  });
                },
              ),
            ],
          ),
          Stack(
            children: [
              Divider(
                thickness: 0.8,
                indent: 10,
                endIndent: 10,
                color: whiteColor,
              ),
              Container(
                child: AnimatedAlign(
                  alignment: alignment,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: Container(
                    height: 3,
                    width: 50,
                    margin: EdgeInsets.only(left: 70, right: 84, top: 6),
                    color: Color(0xFF31A6DC),
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Icon(
                Icons.view_agenda,
                color: whiteColor,
              ),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 20),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height - (168 + 31 + 16 + 24),
              child: listTypeInt),
        ],
      ),
    );
  }
}
