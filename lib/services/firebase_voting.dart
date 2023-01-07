import 'dart:async';

import 'package:eurovisionvoteapp/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/vote.dart';
import '../widgets/scroll_snap_list.dart';
import '../UI/entries/widgets/vote_picker.dart';

final database = FirebaseDatabase.instance.ref();
final user = FirebaseAuth.instance.currentUser;

bool writeVote(int year, String country, int vote, int event) {
  Map<int, String> eventDict = {
    1: "first_semi",
    2: "second_semi",
    3: "grand_final"
  };
  bool success = false;
  String path = 'voting/${user!.uid}/$year/${eventDict[event]}/';
  database
      .child(path)
      .update({'$country': vote})
      .then((_) => success = true)
      .catchError((e) => print("Error: $e"));
  return success;
}

class VoteHandler extends StatefulWidget {
  const VoteHandler({Key? key}) : super(key: key);

  @override
  State<VoteHandler> createState() => _VoteHandlerState();
}

class _VoteHandlerState extends State<VoteHandler> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activateListeners(123, "fdsa");
  }

  void _activateListeners(year, country) {
    StreamSubscription _voteStream;
    var vote;
    final path = "voting/"; //$uid/$year/$country";
    print(path);
    _voteStream = database.child(path).onValue.listen((event) {
      print("Print raw: ${event.snapshot.value}");
      //vote = int.parse(event.snapshot.value.toString());
      print("Recives: $vote");
    });
    _voteStream.cancel();
    print("Read vote: $vote");
  }

  @override
  Widget build(BuildContext context) {
    return Text("Test");
  }
}

/*Stream<List<Vote>> readVote(int year, String uid) {
  final voteStream =
      database.child('votes/$uid/$year/').limitToLast(50).onValue;
  final streamToPublish = voteStream.map((event) {
    final voteMap = Map<Object?, dynamic>.from(
        event.snapshot.value as Map<Object?, dynamic>);
    final voteList = voteMap.entries.map((element) {
      return Vote.fromRTDB(Map<String, dynamic>.from(element.value));
    }).toList();
    return voteList;
  });
  return streamToPublish;
}*/

class VoteDisplay extends StatelessWidget {
  String country;
  int year, event;
  VoteDisplay(this.country, this.year, this.event);
  @override
  Widget build(BuildContext context) {
    Vote vote;
    return StreamBuilder(
      stream: VoteStreamPublisher("Romania", 2022)
          .getVoteStream(), //(country, year, uid).getVoteStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          vote = snapshot.data as Vote;
          print("If: ${vote.vote}");
          return CupertinoVotePicker(country, year, event);
        } else {
          print("Else");
          vote = Vote(0, country, year);
        }
        //final vote = int.parse(snapshot.data.toString());
        //HorizontalListJumbo(country, year, uid);
        //Retunerer hele scrollbaren med riktig vote.

        return CupertinoVotePicker(country, year, event);
        //return HorizontalListJumbo(country, year, uid, vote);
      },
    );
  }
}

/*class VoteStreamPublisherOld {
  final _database = FirebaseDatabase.instance.ref();

  Stream<List<Vote>> getVoteStream(int year, String uid, String country) {
    final voteStream =
        _database.child('votes/$uid/$year/$country/').limitToLast(1).onValue;
    final streamToPublish = voteStream.map((event) {
      final voteMap = Map<Object?, dynamic>.from(
          event.snapshot.value as Map<Object?, dynamic>);
      //entries er ikke en variebel men en "property"
      final voteList = voteMap.entries.map((element) {
        return Vote.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();
      return voteList;
    });
    return streamToPublish;
  }
}*/

class VoteStreamPublisher {
  String country;
  int year;
  final _database = FirebaseDatabase.instance.ref();
  VoteStreamPublisher(this.country, this.year);

  Stream<Vote> getVoteStream() {
    String path = 'voting/${user!.uid}/$year/';
    final voteStream = _database.child(path).limitToLast(50).onValue;

    final streamToPublish = voteStream.map((event) {
      final voteMap = Map<Object?, dynamic>.from(
          event.snapshot.value as Map<Object?, dynamic>);
      Vote vote = Vote(voteMap[country], country, year);
      /*final voteList = voteMap.entries.map((element) {
        return Vote.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();*/
      return vote;
    });
    return streamToPublish;
  }
}





/*
void getVoteFromRTDB(int year, String uid, String country) {
  //return Random().nextInt(10).toDouble();
  final voteToIndex = {
    "1": 1.0,
    "2": 2.0,
    "3": 3.0,
    "4": 4.0,
    "5": 5.0,
    "6": 6.0,
    "7": 7.0,
    "8": 8.0,
    "10": 9.0,
    "12": 10.0
  };
  final path = 'voting/$uid/$year/$country/';
  var voteNew;
  var voteList = [];

  final test = database.child(path).get().then((snapshot) async {
    final data = int.parse(snapshot.value.toString());
    final country = snapshot.key.toString();

    print("Vote: $country: $data");
    final vote = Vote(uid, data, country, year);
    return vote;
  });
  return test;
}*/



/*class VotingScrollSelectorOld extends StatelessWidget {
  final year, uid;

  VotingScrollSelector(this.year, this.uid);

  @override
  Widget build(BuildContext context) {
    //getEntryFromDatabase();
    return StreamBuilder(
        stream: readVote(year, uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tileList = snapshot.data as Map<String?, String?>;
          }
          return ListView(
            children: tileList,
          );
        });
  }
}

class VotingScrollSelector extends StatefulWidget {
    final year, uid;

  VotingScrollSelector(this.year, this.uid);

  @override
  State<VotingScrollSelector> createState() => _VotingScrollSelectorState();
}

class _VotingScrollSelectorState extends State<VotingScrollSelector> {
    var year, uid, country;
    var votesList;


  _VotingScrollSelectorState(this.year, this.uid, this.country);

  @override
  void setState(String newCountry) {
    country = newCountry;
  }


  @override
  Widget build(BuildContext context) {
    //getEntryFromDatabase();
    return StreamBuilder(
        stream: readVote(year, uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            votesList = snapshot.data as Map<String?, String?>;
            
          }
          return vot
        });
  }
}*/