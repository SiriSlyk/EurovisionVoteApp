import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReadExamples extends StatefulWidget {
  @override
  State<ReadExamples> createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples> {
  String _displayText = "Resulat text goes here";
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _dailySpecialStream;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _dailySpecialStream =
        _database.child("Country/description").onValue.listen((event) {
      final String description = event.snapshot.value.toString();
      setState(() {
        _displayText = "Todays special: $description";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read example"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Text(_displayText),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _dailySpecialStream.cancel();
    super.deactivate();
  }
}
