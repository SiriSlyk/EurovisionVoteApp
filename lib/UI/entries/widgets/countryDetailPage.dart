import 'package:eurovisionvoteapp/UI/entries/view/entries_page.dart';
import 'package:eurovisionvoteapp/UI/groups/view/groups_page.dart';
import 'package:eurovisionvoteapp/models/Entries.dart';

import 'package:eurovisionvoteapp/themes/darkTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../index/view/index_page.dart';
import '../../../models/Entry.dart';
import 'vote_picker.dart';
import 'members_widget.dart';

class CountryDetail extends StatelessWidget {
  var flagSize = 100.0;
  Entry entry;
  Entries entries;
  int event;

  CountryDetail(this.entry, this.entries, this.event);

  /*factory CountryDetail.useFirst(Entries entries, int integer) {
    return CountryDetail(entries.getListByInt(integer)[0], entries);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        title: Text(
          "<Group name>",
          style: pageTitleDark,
        ),
        elevation: 0,
        backgroundColor: whiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => EntriesPage() /*IndexPage()*/));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.leaderboard,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.group_add,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: whiteColor,
            height: 100,
            child: MembersTab(),
          ),
          //Padding(
          Container(
            child: Row(
              children: buildNavBar(context),
              /*[
                navCountry(entries.getPrevious(entry), 'left', context),
                Spacer(),
                navCountry(entries.getNext(entry), 'right', context)
              ],*/
            ),
            color: backgroundColor,
            height: 200
            //padding: const EdgeInsets.only(top: 100, bottom: 100),
            ,
          ),
          //Spacer(),
          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: infoDisplay(context)),
          ),

          //height: MediaQuery.of(context).size.height / 10,
          /*child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
          ),*/
        ],
      ),
    );
  }

  Widget infoDisplay(context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /*Container(
          color: darkBlueColor,
          width: MediaQuery.of(context).size.width,
          height: flagSize / 2 + 2,
          //height: MediaQuery.of(context).size.height / 10,
          /*child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
          ),*/
        ),*/
        Container(
          color: darkBlueColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 75),
            child: Column(
              children: getInformation(),
            ),
          ),
        ),
        Positioned(
            top: flagSize / -2,
            left: 0,
            right: 0,
            child: Container(
              child: SvgPicture.asset(
                'icons/flags/svg/' + entry.countryCode.toLowerCase() + '.svg',
                package: 'country_icons',
                height: flagSize,
              ),
            )),
      ],
    );
  }

  List<Widget> buildNavBar(BuildContext context) {
    List<Widget> list = [];
    if (entries.hasPrevious(entry)) {
      list.add(navCountry(entries.getPrevious(entry), 'left', context));
    }
    list.add(Spacer());
    if (entries.hasNext(entry)) {
      list.add(navCountry(entries.getNext(entry), 'right', context));
    }
    return list;
  }

  List<Widget> getInformation() => [
        Text(
          entry.country,
          style: TextStyle(color: whiteColor, fontSize: 30),
        ),
        Text(entry.title, style: TextStyle(color: whiteColor, fontSize: 20)),
        Text(entry.artist, style: TextStyle(color: whiteColor, fontSize: 20)),
        Container(
          height: 150,
        ),
        /*VoteDisplay(FirebaseAuth.instance.currentUser!.uid,
                      entry.country, 2022),*/
        CupertinoVotePicker(entry.country, 2022, event),
        /*HorizontalListJumbo(
                      entry, 2022, FirebaseAuth.instance.currentUser!.uid),*/
        //CupertinoVotePicker(),
        Container(color: Colors.red),
      ];

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
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                CountryDetail(entry, entries, event),
            transitionDuration: Duration.zero,
          ),
        );

        /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CountryDetail(entry, entries),
            ));*/
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

  Widget oldDesign() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: whiteColor),
        child: SvgPicture.asset(
          'icons/flags/svg/' + entry.countryCode.toLowerCase() + '.svg',
          package: 'country_icons',
          height: 75,
        ),
      );
}

/*infoDisplay(context),
                    Container(
                        child: Column(
                          children: getInformation(),
                        ),
                        color: darkBlueColor,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2 -
                            2 -
                            flagSize),*/

