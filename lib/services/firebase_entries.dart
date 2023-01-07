import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/Entries.dart';
import '../models/Entry.dart';
import '../UI/entries/widgets/countryDetailPage.dart';

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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              CountryDetail(nextEntry, myEntriesAll, integer)));
                    },
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      constraints: BoxConstraints(minWidth: 10, maxWidth: 70),
                      height: double.infinity,
                      width: double.infinity,
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

class CountryStreamPublisher {
  final _database = FirebaseDatabase.instance.ref();

  Stream<List<Entry>> getEntryStream(int year) {
    final entryStream =
        _database.child('years/2022/entries').limitToLast(50).onValue;
    final streamToPublish = entryStream.map((event) {
      final entryMap = Map<Object?, dynamic>.from(
          event.snapshot.value as Map<Object?, dynamic>);
      final entryList = entryMap.entries.map((element) {
        return Entry.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();
      return entryList;
    });
    return streamToPublish;
  }
}
