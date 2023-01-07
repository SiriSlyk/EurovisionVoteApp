import 'package:eurovisionvoteapp/models/Entry.dart';
import 'package:eurovisionvoteapp/models/Year.dart';
import 'package:firebase_database/firebase_database.dart';

class CountryStreamPublisher {
  final _database = FirebaseDatabase.instance.ref();
  final _datbase = FirebaseDatabase.instance.ref();

  Stream<List<Entry>> getEntryStream(int year) {
    final entryStream =
        _database.child('years/2022/entries').limitToLast(44).onValue;
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
