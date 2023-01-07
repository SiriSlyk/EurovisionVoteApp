import 'dart:math';

import 'package:eurovisionvoteapp/models/json.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteExample extends StatefulWidget {
  @override
  State<WriteExample> createState() => _WriteExampleState();
}

class _WriteExampleState extends State<WriteExample> {
  final database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final dailySpecialRef = database.child('/orders');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Write example"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> nextOrder;
                  for (var value in countryJson) {
                    nextOrder = value;
                    database.child('years/2022/entries').push().set(nextOrder);
                  }
                  /*final nextOrder = <String, dynamic>{
                    "country": "Netherlands",
                    "country-code": "Nl",
                    "artist": "S10",
                    "title": "De diepte",
                    "semi-number": 1,
                    "semi-draw": 8,
                    "semi-place": null,
                    "quailfied": null,
                    "final-draw": null,
                    "final-place": null
                  };*/
                },
                child: Text("Add country"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
