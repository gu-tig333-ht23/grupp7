import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../class_votering.dart';

Future<List<voteringar>> apiGetList(iid) async {
  final String antal = '100';
  final String url =
      'https://data.riksdagen.se/voteringlista/?rm=&bet=&punkt=&valkrets=&rost=&iid=$iid&sz=$antal&utformat=json&gruppering=';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> voteringlista = jsonData['voteringlista']['votering'];

      if (voteringlista != null && voteringlista is List) {
        List<voteringar> datapoints =
            voteringlista.map((json) => voteringar.fromJson(json)).toList();
        return datapoints;
      } else {
        print('voteringlista is not a List.');
        return [];
      }
    } else {
      print('Failed to get data. Error: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    print('Error: $error');
    return [];
  }
}

Future<Map<String, String>?> fetchDataFromXML(
    String URL, String punktNum) async {
  final url = URL;
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final document = XmlDocument.parse(response.body);
    final voteringElement =
        document.findElements('utskottsforslag').firstOrNull;

    if (voteringElement != null) {
      final dokumentElement =
          voteringElement.findElements('dokument').firstOrNull;

      if (dokumentElement != null) {
        final titleElement = dokumentElement.findElements('titel').firstOrNull;
        final systemdatumElement =
            dokumentElement.findElements('systemdatum').firstOrNull;

        if (titleElement != null && systemdatumElement != null) {
          final Map<String, String> data = {
            'title': titleElement.text,
            'datum': systemdatumElement.text,
          };

          final utskottsforslagElements =
              document.findAllElements('utskottsforslag');

          // Loop through utskottsforslag elements
          for (final utskottsforslagElement in utskottsforslagElements) {
            final punktElement =
                utskottsforslagElement.findElements('punkt').firstOrNull;

            if (punktElement != null && punktElement.text == punktNum) {
              final rubrikElement =
                  utskottsforslagElement.findElements('rubrik').firstOrNull;

              if (rubrikElement != null) {
                data['rubrik'] = rubrikElement.text;
              } else {
                print('No <rubrik> tag found for punkt $punktNum.');
                return null;
              }
            }
          }

          return data;
        } else {
          print('No <titel> or <systemdatum> tag found in the XML.');
          return null;
        }
      } else {
        print('No <dokument> tag found in the XML.');
        return null;
      }
    } else {
      print('No <votering> tag found in the XML.');
      return null;
    }
  } else {
    print('Failed to fetch XML.');
    return null;
  }
}

extension FirstOrNullExtension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : this.first;
}
