import 'package:eurovisionvoteapp/models/Entry.dart';

class Year {
  int year;
  String country, city, winner;
  int entriesCount = 0; //int
  List<Entry> entries;
  List<Entry> semiOne = [];
  List<Entry> semiTwo = [];
  List<Entry> grandFinal = [];
  int iterateCount = 0;

  Year(this.year, this.country, this.city, this.winner, this.entries) {
    semiOne = getSemiList(entries, 1);
    //List<Entry> semiTwo = getSemiList(entries, 2);
    List<Entry> grandFinal = getFinalList(entries);
    entriesCount = entries.length;
  }

  factory Year.fromRTDB(Map<String, dynamic> data) {
    return Year(
      data['year'],
      data['country'] ?? 'TBA',
      data['city'] ?? 'TBA',
      data['winner'] ?? 'TBA',
      data['entries'], // ?? [],
    );
  }

  List<Entry> getSemiOne() {
    return semiOne;
  }

  List<Entry> getSemiTwo() {
    return semiTwo;
  }

  List<Entry> getFinal() {
    return grandFinal;
  }

  @override
  String toString() {
    String listStr = '';
    for (var entry in getSemiOne()) {
      listStr += entry.toString();
    }
    String str =
        '$year: participents: $entriesCount, Country:$country, City:$city,Participents: $semiOne';
    return str;
  }

  Entry getNextEntry() {
    return semiOne[iterateCount];
  }

  int getIteraterInt() {
    /*if (iterateCount >= semiOne.length - 1) {
      return 0;
    }*/
    return iterateCount++;
  }
}

List<Entry> getSemiList(List<Entry> list, int value) {
  List<Entry> semi = [];

  for (Entry entry in list) {
    if (entry.semiNr == value) {
      semi.add(entry);
    }
  }

  semi.sort((a, b) => a.semiDraw.compareTo(b.semiDraw));

  return semi;
}

List<Entry> getFinalList(List<Entry> list) {
  List<Entry> grandFinal = [];
  for (Entry entry in list) {
    if (entry.qualified) {
      grandFinal.add(entry);
    }
  }
  grandFinal.sort((a, b) => a.semiDraw.compareTo(b.semiDraw));
  return grandFinal;
}
