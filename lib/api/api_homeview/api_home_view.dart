import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/model_dokument.dart';

DateTime todaysDate = DateTime.now();
DateTime startSearchDate = todaysDate.subtract(Duration(days: 30 * 6));
String numberofResults = '&sz=500';

const String endPoint =
    'https://data.riksdagen.se/dokumentlista/?sok=&doktyp=votering&rm=&ts=&bet=&tempbet=&nr=&org=&iid=&avd=&webbtv=&talare=&exakt=&planering=&facets=&sort=datum&sortorder=desc&rapport=&utformat=json&a=s';

Future<List<Dokument>> apiGetDokuments() async {
  String url =
      '$endPoint&from=$startSearchDate&tom=$todaysDate$numberofResults';

  http.Response response = await http.get(Uri.parse(url));
  Map<String, dynamic> jsonData = jsonDecode(response.body);
  List<dynamic> dokumentsJson = jsonData['dokumentlista']['dokument'];
  return dokumentsJson.map((json) => Dokument.fromJson(json)).toList();
}
