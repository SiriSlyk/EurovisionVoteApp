import 'package:eurovisionvoteapp/models/Entries.dart';
import 'package:eurovisionvoteapp/models/Entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'countryDetailPage.dart';
import 'countryStream.dart';

class CountryDisplay extends StatelessWidget {
  int integer;
  CountryDisplay(this.integer);

  Text getInfo(Entry nextEntry) {
    Text text;
    if (integer == 3) {
      text = Text(
          nextEntry.semiNr.toString() +
              '. ' +
              nextEntry.finalDraw.toString() +
              ' ' +
              nextEntry.country,
          style: TextStyle(color: Colors.white));
    } else {
      text = Text(
          nextEntry.semiNr.toString() +
              '. ' +
              nextEntry.semiDraw.toString() +
              ' ' +
              nextEntry.country,
          style: TextStyle(color: Colors.white));
    }
    return text;
  }

  Widget build(BuildContext context) {
    //getEntryFromDatabase();
    return StreamBuilder(
        stream: CountryStreamPublisher().getEntryStream(2022),
        builder: (context, snapshot) {
          final tileList = <ListTile>[];
          if (snapshot.hasData) {
            final myEntriesAll = Entries(snapshot.data as List<Entry>);
            final myEntries = myEntriesAll.getListByInt(integer);
            tileList.addAll(
              myEntries.map((nextEntry) {
                return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CountryDetail(nextEntry, myEntriesAll),
                          ));
                      //print(nextEntry.country);
                    },
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      constraints: BoxConstraints(minWidth: 10, maxWidth: 70),
                      height: double.infinity,
                      width: double.infinity,
                      child: SvgPicture.asset(
                        'icons/flags/svg/' +
                            nextEntry.countryCode.toLowerCase() +
                            '.svg',
                        package: 'country_icons',
                      ),
                    ),
                    title: getInfo(nextEntry),
                    subtitle: Text(
                      nextEntry.title + ' - ' + nextEntry.artist,
                      style: TextStyle(color: Colors.white),
                    ));
              }),
            );
          }
          return ListView(
            children: tileList,
          );
        });
  }
}
