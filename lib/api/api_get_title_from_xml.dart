import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

Future<Map<String, String>?> fetchTitle(String URL, String punktNum) async {
  print('nytt call');
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
