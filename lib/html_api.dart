import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

const String htmlEndpoint =
    'https://data.riksdagen.se/dokument/HA01$rm$beteckning';

const rm = 'JUU'; // inskickat värde från voteringsvyn
const beteckning = '32'; // inskickat värde från voteringsvyn

Future<void> getSummary() async {
  try {
    http.Response response = await http.get(Uri.parse('$htmlEndpoint'));
    if (response.statusCode == 200) {
      dom.Document html = dom.Document.html(response.body);
      final summary = html
          .querySelector('body > div > p:not(.Sammanfattning) > span')
          ?.innerHtml
          ?.trim(); // Use querySelector to get the first matching element

      if (summary != null) {
        print('Found: $summary');
      } else {
        print('No matching element found');
      }
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('HTTP request error: $e');
  }
}