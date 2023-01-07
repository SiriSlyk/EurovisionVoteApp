import 'package:eurovisionvoteapp/models/Entries.dart';
import 'package:eurovisionvoteapp/models/Entry.dart';
import 'package:eurovisionvoteapp/main.dart';
import 'package:eurovisionvoteapp/themes/darkTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryDetail extends StatelessWidget {
  Entry entry;
  Entries entries;
  CountryDetail(this.entry, this.entries);

  factory CountryDetail.useFirst(Entries entries, int integer) {
    return CountryDetail(entries.getListByInt(integer)[0], entries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ));
            },
          ),
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
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 100),
            child: Row(
              children: [
                navCountry(entries.getPrevious(entry), 'left', context),
                Spacer(),
                navCountry(entries.getNext(entry), 'right', context)
              ],
            ),
          ),
          Spacer(),
          Container(
            color: darkBlueColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: whiteColor),
                    child: SvgPicture.asset(
                      'icons/flags/svg/' +
                          entry.countryCode.toLowerCase() +
                          '.svg',
                      package: 'country_icons',
                      width: 100,
                    ),
                  ),
                  Text(
                    entry.country,
                    style: TextStyle(color: whiteColor, fontSize: 30),
                  ),
                  Text(entry.title,
                      style: TextStyle(color: whiteColor, fontSize: 20)),
                  Text(entry.artist,
                      style: TextStyle(color: whiteColor, fontSize: 20)),
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 70,
                    color: whiteColor,
                    child: TextField(
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget navCountry(Entry entry, String direction, BuildContext context) {
    return Container(
      decoration: getDecoration(direction),
      width: 100,
      height: 50,
      //constraints: BoxConstraints(minWidth: 10, maxWidth: 70, minHeight: ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: getNavDirection(entry, entries, direction, context),
      ),
    );
  }

  Widget getNavDirection(
      Entry entry, Entries entries, String direction, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CountryDetail(entry, entries),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.1, //5
              blurRadius: 30, //7
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: getFlag(direction, entry),
      ),
    );
  }

  Widget getFlag(String direction, Entry entry) {
    if (direction == 'right') {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              'icons/flags/svg/' + entry.countryCode.toLowerCase() + '.svg',
              package: 'country_icons',
              width: 50,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios_outlined),
            Spacer(),
            SvgPicture.asset(
              'icons/flags/svg/' + entry.countryCode.toLowerCase() + '.svg',
              package: 'country_icons',
              width: 50,
            ),
          ],
        ),
      );
    }
  }

  BoxDecoration getDecoration(String direction) {
    if (direction == 'right') {
      return BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      );
    } else {
      return BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      );
    }
  }
}
