import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../services/firebase_voting.dart';
import 'friends.dart';

class Bruker {
  String uid, name, email, image;
  List<Bruker> friends;
  //var test = [];
  Map<String, int> votes = {};
  List<String> frinedsList = [];

  Bruker(this.uid, this.name, this.image, this.email, this.friends);

  factory Bruker.fromRTDB(key, value) {
    //var key = map.key;
    //var val = map.value["info"];

    return Bruker(
      key,
      value["name"],
      value["image"],
      value["email"],
      [],
    ); /*Bruker(
      key,
      val["name"],
      val["image"],
      val["email"],
      [],
    );*/
  }

  factory Bruker.fromGoogleFriends(user, friendsList) {
    return Bruker(
        user!.uid, user!.displayName, user!.photoURL, user!.email, friendsList);
  }
  factory Bruker.fromGoogle(user) {
    List<Bruker> list = [];
    return Bruker(
        user!.uid, user!.displayName, user!.photoURL, user!.email, list);
  }

  Future<void> readUser() async {
    //Future<List<String>> readUser() async {
    String path = "user/$uid/friends";

    var snapshot = await database.child(path).once();

    snapshot.snapshot.children.forEach((element) {
      frinedsList.add(element.key.toString());
    });
  }

  String getFriendPath(String country) {
    return "user/$uid/votes/$country";
  }

/*void readUser() {
    var _userStream;
    final database = FirebaseDatabase.instance.ref();
    List<String> list = [];

    String path = "user/$uid/friends";
    _userStream = database.child(path).onValue.listen((event) {
      //test.add(event.snapshot.value);
      var data = event.snapshot.value;
      final tempList = (data as Map<Object?, dynamic>).keys.toList();
      list = tempList.map((element) => element.toString()).toList();
      print(list);
    });
    print(list);
    //return test;
  }

*/
}
