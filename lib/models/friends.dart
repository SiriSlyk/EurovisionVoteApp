import 'user.dart';

class Friends {
  List<Bruker> friends = [];
  Friends(this.friends);

  factory Friends.fromRTDB(Map<dynamic, dynamic> map) {
    //print(map);
    List<Bruker> list = [];
    /*map.entries.map(
      (element) {
        //list.add(Bruker.fromRTDB(element));
        print(list);
      },
    );*/
    map.forEach((key, value) {
      //print("$key: ${value['info']['name']}");
      list.add(Bruker.fromRTDB(key, value["info"]));
    });

    return Friends(list);
  }

  void addFriend(Bruker friend) {
    friends.add(friend);
  }

  int friendsCount() {
    return friends.length;
  }

  bool removeFriend(Bruker friend) {
    return friends.remove(friend);
  }
}
