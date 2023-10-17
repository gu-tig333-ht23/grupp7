class voteringar {
  final String hangarId;
  final String rm;
  final String beteckning;
  final String punkt;
  final String voteringId;
  final String intressentId;
  final String namn;
  final String fornamn;
  final String efternamn;
  final String valkrets;
  final String iort;
  final String parti;
  final String banknummer;
  final String kon;
  final String fodd;
  final String rost;
  final String avser;
  final String votering;
  final String voteringUrlXml;
  final String dokId;
  final String systemdatum;
  String titel = '';
  String underTitel = '';

  voteringar({
    required this.hangarId,
    required this.rm,
    required this.beteckning,
    required this.punkt,
    required this.voteringId,
    required this.intressentId,
    required this.namn,
    required this.fornamn,
    required this.efternamn,
    required this.valkrets,
    required this.iort,
    required this.parti,
    required this.banknummer,
    required this.kon,
    required this.fodd,
    required this.rost,
    required this.avser,
    required this.votering,
    required this.voteringUrlXml,
    required this.dokId,
    required this.systemdatum,
  });

  factory voteringar.fromJson(Map<String, dynamic> json) {
    return voteringar(
      hangarId: json['hangar_id'],
      rm: json['rm'],
      beteckning: json['beteckning'],
      punkt: json['punkt'],
      voteringId: json['votering_id'],
      intressentId: json['intressent_id'],
      namn: json['namn'],
      fornamn: json['fornamn'],
      efternamn: json['efternamn'],
      valkrets: json['valkrets'],
      iort: json['iort'],
      parti: json['parti'],
      banknummer: json['banknummer'],
      kon: json['kon'],
      fodd: json['fodd'],
      rost: json['rost'],
      avser: json['avser'],
      votering: json['votering'],
      voteringUrlXml: json['votering_url_xml'],
      dokId: json['dok_id'],
      systemdatum: json['systemdatum'],
    );
  }
}
