import 'package:eurovisionvoteapp/models/Entry.dart';

class Entries {
  List<Entry> entryList;

  Entries(this.entryList);

  int type = 3;

  List<Entry> getListByInt(int integer) {
    type = integer;
    if (type == 1) {
      return getFirstSemi();
    }
    if (type == 2) {
      return getSecondSemi();
    } else {
      return getFinal();
    }
  }

  List<Entry> getFirstSemi() {
    return getSemi(1);
  }

  List<Entry> getSecondSemi() {
    return getSemi(2);
  }

  List<Entry> getFinal() {
    List<Entry> entries = [];
    for (Entry entry in entryList) {
      if (entry.qualified) {
        entries.add(entry);
      }
    }
    entries.sort((a, b) => a.finalDraw.compareTo(b.finalDraw));

    return entries;
  }

  List<Entry> getSemi(int number) {
    List<Entry> entries = [];
    for (Entry entry in entryList) {
      if (entry.semiNr == number) {
        entries.add(entry);
      }
    }
    entries.sort((a, b) => a.semiDraw.compareTo(b.semiDraw));
    return entries;
  }

  Entry getNext(Entry entry) {
    List<Entry> list;
    if (type == 1) {
      list = getFirstSemi();
    } else if (type == 2) {
      list = getSecondSemi();
    } else {
      list = getFinal();
    }
    int index = list.indexOf(entry) + 1;
    if (index >= list.length) {
      return entry;
    }
    return list[index];
  }

  Entry getPrevious(Entry entry) {
    List<Entry> list;
    if (type == 1) {
      list = getFirstSemi();
    } else if (type == 2) {
      list = getSecondSemi();
    } else {
      list = getFinal();
    }
    int index = list.indexOf(entry) - 1;
    if (index <= 0) {
      return entry;
    }
    return list[index];
  }
}
