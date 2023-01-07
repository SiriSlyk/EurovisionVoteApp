import 'package:eurovisionvoteapp/themes/darkTheme.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../models/Entry.dart';
import '../models/vote.dart';
import '../services/firebase_voting.dart';

class HorizontalListJumbo extends StatefulWidget {
  String country;
  int year;
  Vote currentVote;

  HorizontalListJumbo(this.country, this.year, this.currentVote) {
    print("First ${currentVote.getVote()}");
  }

  @override
  _HorizontalListJumboState createState() =>
      _HorizontalListJumboState(country, year, currentVote.getVote());
}

class _HorizontalListJumboState extends State<HorizontalListJumbo> {
  String country;
  int year;
  final numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 12];
  late Vote voteObj;
  int vote;

  int _focusedIndex = 0;
  var _vote = 0.0;

  _HorizontalListJumboState(this.country, this.year, this.vote) {
    print("Constructor $vote");
  }

  //vote = getVoteFromRTDB(year, googleId, entry.country);
  List<int> data = [];
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    print("vote init: $vote");
    //getVoteFromRTDB(/*year, googleId, entry.country*/);
    for (int i = 0; i < numbers.length; i++) {
      data.add(numbers[i]);
    }
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
      if (index != 0) {
        //writeVote(2022, googleId, entry.country, data[index]);
        print("New vote value: ${data[index]}");
      }
    });
  }

  /*void getVoteFromRTDB(/*int year, String uid, String country*/) {
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
    final path = 'voting/$googleId/$year/$country/';
    var voteNew;
    var voteList = [];

    database.child(path).get().then((snapshot) {
      final data = int.parse(snapshot.value.toString());
      final country = snapshot.key.toString();

      print("Vote: $country: $data");
      final vote = Vote(googleId, data, country, year);
      setState(() {
        voteObj = vote;
        print("I funksjon 1: ${voteObj.vote}");
      });
    });
    print("I funksjon: ${voteObj.vote}");
  }*/

  Widget _buildItemDetail() {
    if (data.length > _focusedIndex)
      return Container(
        height: 0, //350,
        //child: Text("index $_focusedIndex: ${data[_focusedIndex]}"),
      );

    return Container(
      height: 0,
      child: Text("No Data"),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 350,
      height: 20,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Center(
              child: Text(
            data[index].toString(),
            style: TextStyle(fontSize: 30, color: whiteColor),
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ScrollSnapList(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  onItemFocus: _onItemFocus,
                  initialIndex: vote.toDouble(),
                  itemSize: 360,
                  itemBuilder: _buildListItem,
                  itemCount: data.length,
                  key: sslKey,
                ),
              ),
              _buildItemDetail(),
            ],
          ),
        ),
      ],
    );
  }
}
