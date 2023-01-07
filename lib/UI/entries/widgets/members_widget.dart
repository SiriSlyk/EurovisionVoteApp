import 'dart:math';

import 'package:eurovisionvoteapp/themes/darkTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../models/friends.dart';
import '../../../models/user.dart';
import '../../../services/firebase_voting.dart';

final user = FirebaseAuth.instance.currentUser;
Bruker bruker = Bruker.fromGoogle(user);

class MembersTab extends StatelessWidget {
  const MembersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userFriends = bruker.readUser();
    print("First: ${userFriends.toString()}");
    String path = "user/";
    return Container(
        color: whiteColor,
        child: StreamBuilder(
            stream: database.child(path).onValue,
            builder: (context, snapshot) {
              List<Widget> memberView = [];
              if (snapshot.hasData) {
                final test = (snapshot.data! as DatabaseEvent).snapshot.value;

                var map = (test as Map<Object?, dynamic>);
                final members = Friends.fromRTDB(map).friends;
                print(members);
                memberView = memberList(members);
              }
              return ListView(
                  scrollDirection: Axis.horizontal, children: memberView);
            }));
  }

  /*ListView(
        scrollDirection: Axis.horizontal,
        children: membersList(),
      ),*/
}

List<Widget> memberList(List<Bruker> list) {
  List<Widget> members = [];
  members.add(addMemberItem());
  for (int i = 0; i < list.length; i++) {
    members.add(memberItem(list[i]));
  }
  return members;
}

Widget addMemberItem() {
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30),
      child: Container(
        child: Icon(
          Icons.add,
          color: whiteColor,
          size: 35,
        ),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: darkBlueColor,
        ),
      ),
    ),
    onTap: () {
      print("New memeber added");
    },
  );
}

/*Widget getFriendsDetails(context) {
    String path = "user/";
    var newList = [];
    var test = bruker.readUser();
    test.then((value) {
      value.forEach((element) {
        newList.add(element);
      });
    });
    print(newList);

    return StreamBuilder(
        stream: database.child(path).onValue,
        builder: (context, snapshot) {
          final memberView = [];
          if (snapshot.hasData) {
            final members = Map<String, dynamic>.from(
                snapshot.data as Map<String, dynamic>);
          }
        });
  }*/

Widget memberItem(Bruker bruker) {
  //var gfd = stream.map((event) {
  //  print(event.contains("q0oQyDO6QjeR9n6oAL1UbDNHVFA2"));
  //});
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Container(
          child: CircleAvatar(
            backgroundImage: NetworkImage(bruker.image),
            radius: 20,
          ),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: darkBlueColor,
          ),
        ),
      ),
      Positioned(
        top: 55,
        left: 12,
        right: 12,
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  getVoteAsString(bruker, "norway"),
                  //"12",
                  //bruker.votes["finland"].toString(), //Her skal voten hentes inn
                  textAlign: TextAlign.center,
                  style: TextStyle(color: whiteColor),
                ),
              ),
              height: 20,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: Color(0xFF292531),
              ),
            ),
            Text(
              bruker.name, //"Name Lastname",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      )
    ],
  );
}

//JUST FOR DEMO, NOT CONNECTED TO FIREBASE
/*List<Widget> membersListOLD() {
    List<Widget> list = [];
    list.add(addMemberItem());
    for (int i = 0; i < 1; i++) {
      int random = Random().nextInt(10);
      var intList = [1, 2, 3, 4, 5, 6, 7, 8, 10, 12];
      list.add(memberItem(intList[random]));
    }
    return list;
  }*/

void streamMembers() {}

/*String getVoteStream(Bruker friend, String country) {
  String str;
  var stream = StreamBuilder(
      stream: database.child(friend.getFriendPath(country)).onValue,
      builder: (context, snapshot) {
        List<Widget> memberView = [];
        if (snapshot.hasData) {
          final test = (snapshot.data! as DatabaseEvent).snapshot.value;
          str = test.toString();
          if (test != null) {
            return Text(str);
          }
          return Text("-");
        }
        return Text("123");
        //return ListView(scrollDirection: Axis.horizontal, children: memberView);
      });
  return stream.toString();
}*/

String getVoteAsString(Bruker friend, String country) {
  String str;
  String path = friend.getFriendPath(country);
  str = database.child(path).onValue.listen((event) {
    final vote = event.snapshot.value;
    print(vote.toString());
  }) as String;
  return str;
}
