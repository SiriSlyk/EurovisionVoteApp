import 'package:eurovisionvoteapp/themes/darkTheme.dart';
import 'package:flutter/material.dart';

import 'groupBoxes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        title: Text(
          '2022',
          style: TextStyle(fontSize: 32, color: Colors.black),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  print("Arrow down pressed");
                },
                child: const Icon(Icons.arrow_drop_down_outlined,
                    color: Colors.black),
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GroupBoxes(),
    );
  }
}
