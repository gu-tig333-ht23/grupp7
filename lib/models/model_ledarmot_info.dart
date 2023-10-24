import 'dart:convert';

class LedamotInfo {
  final String imageUrl;
  final String ledamotNamn;
  final String ledamotStatus;
  final String ledamotParti;

  LedamotInfo({
    required this.imageUrl,
    required this.ledamotNamn,
    required this.ledamotStatus,
    required this.ledamotParti,
  });

  factory LedamotInfo.fromJson(String jsonString) {
    final Map<String, dynamic> map = json.decode(jsonString);
    return LedamotInfo.fromMap(map);
  }

  factory LedamotInfo.fromMap(Map<String, dynamic> map) {
    final personData = map['personlista']['person'];

    final imageUrl = personData['bild_url_192'];
    final ledamotNamn =
        '${personData['tilltalsnamn']} ${personData['efternamn']} ${personData['parti']}';
    final ledamotStatus = personData['status'];
    final ledamotParti = '${personData['parti']}';

    return LedamotInfo(
      imageUrl: imageUrl,
      ledamotNamn: ledamotNamn,
      ledamotStatus: ledamotStatus,
      ledamotParti: ledamotParti,
    );
  }
}
