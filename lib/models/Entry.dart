class Entry {
  String country, countryCode, artist, title;
  int semiNr, semiDraw, finalDraw;
  bool qualified;

  Entry(this.country, this.countryCode, this.artist, this.title, this.semiNr,
      this.semiDraw, this.finalDraw, this.qualified);

  factory Entry.fromRTDB(data) {
    return Entry(
        data['country'] ?? 'TBA',
        data['country-code'] ?? 'No',
        data['artist'] ?? 'TBA',
        data['title'] ?? 'TBA',
        data['semi-number'] ?? 0,
        data['semi-draw'] ?? 0,
        data['final-draw'] ?? 0,
        data['qualified'] ?? false);
  }

  @override
  String toString() {
    String str =
        "Country: $country, artist: $artist, title: $title, semiNr: $semiNr, semiDraw: $semiDraw, finalDraw: $finalDraw, qualiied: $qualified\n";
    return str;
  }
}
