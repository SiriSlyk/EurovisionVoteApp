import 'package:flutter/material.dart';

import '../../../themes/darkTheme.dart';

class GroupBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        for (int i = 0; i < 10; i++) GroupBox(),
      ],
    );
  }
}

class GroupBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            Container(
              child: Text("<Group name>",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
          color: darkBlueColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ));
  }
}
