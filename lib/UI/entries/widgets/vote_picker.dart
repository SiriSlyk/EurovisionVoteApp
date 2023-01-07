import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../models/vote.dart';
import '../../../services/firebase_voting.dart';
import '../../../themes/darkTheme.dart';

const double _kItemExtent = 32.0;
final user = FirebaseAuth.instance.currentUser;
const List<String> _fruitNames = <String>[
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '10',
  '12'
];

class CupertinoVotePicker extends StatefulWidget {
  String country;
  int year, event;

  CupertinoVotePicker(this.country, this.year, this.event);

  @override
  State<CupertinoVotePicker> createState() =>
      _CupertinoPickerSampleState(country, year, event);
}

class _CupertinoPickerSampleState extends State<CupertinoVotePicker> {
  String country;
  int year, event;
  var _voteStream;
  final database = FirebaseDatabase.instance.ref();
  late FixedExtentScrollController scrollController;
  int _tempVote = 0;
  int _vote = 0;
  _CupertinoPickerSampleState(this.country, this.year, this.event);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activateListeners();
    scrollController = FixedExtentScrollController(initialItem: _vote);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _activateListeners() {
    Map<int, String> eventDict = {
      1: "first_semi",
      2: "second_semi",
      3: "grand_final"
    };
    //Read vote

    String path = "voting/${user!.uid}/$year/${eventDict[event]}/$country";
    _voteStream = database.child(path).onValue.listen((event) {
      final vote = event.snapshot.value;
      setState(() {
        if (vote == null) {
          _vote = 0;
        } else {
          _vote = int.parse(vote.toString());
        }
      });
    });
  }

  //int _selectedFruit = voteInit; //DER SKAL VOTE INN!!!!!

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 200,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: darkBlueColor,
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //const Text('Vote '),
              CupertinoButton(
                padding: EdgeInsets.zero,
                // Display a CupertinoPicker with list of fruits.
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                            actions: [buildPicker()],
                            cancelButton: CupertinoActionSheetAction(
                              child: Text("Select"),
                              onPressed: () {
                                _vote = _tempVote;
                                writeVote(year, country, _vote, event);
                                Navigator.pop(context);
                              },
                            ),
                          ));
                },
                //onPressed: () => _showDialog(buildPicker()),
                // This displays the selected fruit name.

                child: Text(
                  _fruitNames[_vote],
                  style: const TextStyle(fontSize: 32.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _voteStream.cancel();
    super.deactivate();
  }

  Widget buildPicker() {
    return SizedBox(
      height: 300,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: _vote),
        magnification: 1.22,
        squeeze: 1.2,
        useMagnifier: true,
        itemExtent: _kItemExtent,
        // This is called when selected item is changed.
        onSelectedItemChanged: (int selectedItem) {
          setState(() {
            _tempVote = selectedItem;
            //Write to firebase
            //writeVote(year, country, _vote);
          });
        },
        children: List<Widget>.generate(_fruitNames.length, (int index) {
          return Center(
            child: Text(
              _fruitNames[index],
            ),
          );
        }),
      ),
    );
  }
}
