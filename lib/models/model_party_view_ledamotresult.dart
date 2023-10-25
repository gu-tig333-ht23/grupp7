class LedamotResult {
  final String namn;
  final String party;
  final String intressentId;
  final String punkt;
  final String vote;

  LedamotResult(
      {required this.namn,
      required this.party,
      required this.intressentId,
      required this.punkt,
      required this.vote});

  factory LedamotResult.fromJson(Map<String, dynamic> json) {
    return LedamotResult(
        namn: json['namn'] ?? '',
        party: json['parti'] ?? '',
        intressentId: json['intressent_id'],
        punkt: json['punkt'],
        vote: json['rost']);
  }
}
