class Ledamot {
  final String tilltalsnamn;
  final String efternamn;
  final String bildUrl80;
  final String party;
  final String intressentId;
  final bool partiLedare;

  Ledamot(
      {required this.tilltalsnamn,
      required this.efternamn,
      required this.bildUrl80,
      required this.party,
      required this.intressentId,
      this.partiLedare = false});

  factory Ledamot.fromJson(Map<String, dynamic> json) {
    // Extracting the list of "uppdrag" from "personuppdrag"
    final List<dynamic> uppdragList = json['personuppdrag']['uppdrag'] ?? [];

    // Check if any "uppdrag" has "roll_kod" = "Partiledare" or "Språkrör"
    final bool isPartiLedare = uppdragList.any((uppdrag) =>
        (uppdrag['roll_kod'] == 'Partiledare' ||
            uppdrag['roll_kod'] == 'Språkrör') &&
        uppdrag['tom'] == "");

    return Ledamot(
        tilltalsnamn: json['tilltalsnamn'] ?? '',
        efternamn: json['efternamn'] ?? '',
        bildUrl80: json['bild_url_80'] ?? '',
        party: json['party'] ?? '',
        intressentId: json['intressent_id'],
        partiLedare: isPartiLedare);
  }
}
