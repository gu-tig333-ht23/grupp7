import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

const String htmlEndpoint = 'https://data.riksdagen.se/dokument/HA01$rm$beteckning';

const rm = 'au'; // inskickat värde från voteringsvyn
const beteckning = '9'; // inskickat värde från voteringsvyn

Future<void> getSummary() async {
  try {
    http.Response response = await http.get(Uri.parse(htmlEndpoint));
    if (response.statusCode == 200) {
      dom.Document html = dom.Document.html(response.body);

      bool isParsing = false;
      String singleSpanParagraphs = '';
      String multipleSpanParagraphs = '';

      html.querySelectorAll('p').forEach((element) {
        if (element.classes.contains('Sammanfattning')) {
          isParsing = true;
        } else if (element.classes.contains('Innehllsfrteckning')) {
          isParsing = false;
        } else if (isParsing) {
          List<dom.Element> spans = element.querySelectorAll('span'); // Hämtar alla span-objekt
          final text = spans
              .where((spanElement) => spanElement.attributes['style'] == null) // Filtrerar ut <span style> objekt som fuckar upp
              .map((spanElement) => spanElement.innerHtml.trim())
              .join(' ');

          if (spans.length == 1) {
            if (text.isNotEmpty) {
              singleSpanParagraphs += '$text\n';
            }
          } else {
            if (text != '&nbsp;' || text != '&shy;') {
              singleSpanParagraphs += '$text\n';
            }
          }
          if (text.isNotEmpty || text != '&nbsp;' || text != '&shy;') {
            multipleSpanParagraphs += '$text ';
          }
        }
      }
    );

      if (singleSpanParagraphs.isNotEmpty) {
        print('Single Span Paragraphs:');
        print(singleSpanParagraphs); // Presenterar alla stycken i varsin paragraf
      }

      if (multipleSpanParagraphs.isNotEmpty) {
        print('Multiple Span Paragraphs:');
        print(multipleSpanParagraphs); // Presenterar alla stycken i en sammanhängande paragraf
      }

    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('HTTP request error: $e');
  }
}