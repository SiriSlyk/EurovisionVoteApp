import 'package:firebase_database/firebase_database.dart';

import '../main.dart';

class Vote {
  int vote;
  String country;
  int year;

  Vote(this.vote, this.country, this.year);

  factory Vote.fromRTDB(data) {
    return Vote(
      //data['uid'],
      data['vote'],
      data['country'],
      data['year'],
    );
  }
  int getVote() {
    return vote;
  }
}

class VoteStreamPublisher {
  final _database = FirebaseDatabase.instance.ref();

  Stream<List<Vote>> getVoteStream(int year, String country) {
    final voteStream = _database
        .child('votes/${user!.uid}/$year/$country/')
        .limitToLast(1)
        .onValue;
    final streamToPublish = voteStream.map((event) {
      final voteMap = Map<Object?, dynamic>.from(
          event.snapshot.value as Map<Object?, dynamic>);
      final voteList = voteMap.entries.map((element) {
        return Vote.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();
      return voteList;
    });
    return streamToPublish;
  }
}
