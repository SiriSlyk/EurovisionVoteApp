import 'package:eurovisionvoteapp/Languages/en_lang.dart';
import 'package:eurovisionvoteapp/themes/darkTheme.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import '../../../models/Entries.dart';
import '../../../models/Entry.dart';
import '../../../services/firebase_entries.dart';
import 'countryDetailPage.dart';

class CountryList extends StatefulWidget {
  @override
  State<CountryList> createState() => _CountryList();
}

class _CountryList extends State<CountryList> {
  var alignment = Alignment.center;
  //integer determines start event
  var listTypeInt =
      CountryDisplay(3); //1 for first, 2 for second, 3 for grand final

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: Text(LangEn.firstSemiText),
              onPressed: () {
                setState(() {
                  listTypeInt = CountryDisplay(1);
                  alignment = Alignment.centerLeft;
                });
              },
            ),
            TextButton(
              child: Text(LangEn.grandFinalText),
              onPressed: () {
                setState(() {
                  listTypeInt = CountryDisplay(3);
                  alignment = Alignment.center;
                });
              },
            ),
            TextButton(
              child: Text(LangEn.secondSemiText),
              onPressed: () {
                setState(() {
                  print("Second");
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
          onTap: () {
            print("Button pressed");
          },
          child: Container(
            child: Icon(
              Icons.view_agenda,
              color: whiteColor,
            ),
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
          ),
        ),
        Expanded(

            /*height:
                MediaQuery.of(context).size.height - (168 + 31 + 16 + 24 + 42),
            */
            child: listTypeInt),
      ],
      //),
    );
  }
}
