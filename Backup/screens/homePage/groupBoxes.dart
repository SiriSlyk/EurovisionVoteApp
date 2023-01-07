import 'package:flutter/material.dart';

import 'groupBox.dart';

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
