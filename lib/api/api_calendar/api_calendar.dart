import 'package:http/http.dart' as http;
import 'package:template/screens/calendar_view.dart';
import 'package:xml/xml.dart' as xml;
import '../../models/model_claendarevents.dart';

DateTime getDate = DateTime.now();
String todaysDate =
    getDate.year.toString() + getDate.month.toString() + getDate.day.toString();

List<CalendarEvents?> parseXml(String xmlData) {
  var document = xml.XmlDocument.parse(xmlData);
  var events = document.findAllElements('kalender');

  return events.map((event) {
    var title = event.getElement('SUMMARY')?.innerText ?? '';
    var descriptionElement = event.findElements('DESCRIPTION').skip(1).first;
    var description = descriptionElement.innerText;
    var decisionDate = event.getElement('DTSTART')?.innerText ?? '';

    if (description.isEmpty) {
      return null; // Ignore if description is empty
    }

    description = processDescription(description);
    decisionDate = processDecisionDate(decisionDate);

    int intOfToday = int.parse(todaysDate);
    int intOfDecisionDate = int.parse(decisionDate);
    if (intOfDecisionDate < intOfToday) {
      return null;
    }

    return CalendarEvents(
      title: title,
      description: description,
      decisionDate: decisionDate,
    );
  }).toList();
}

String processDescription(String description) {
  description = description.trim(); // Remove leading and trailing whitespace
  description =
      description.replaceAll(r'\n', '\n'); // Convert '\n' to actual line breaks
  description = description.replaceAll(
      RegExp(r'\n{1,2}$'), ''); // Remove one or two trailing newlines
  description = description.replaceFirst(
      RegExp(r'^\n{1,2}'), ''); // Remove one or two leading newlines

  return description;
}

String processDecisionDate(String decisionDate) {
  decisionDate = decisionDate.replaceRange(8, null, '');
  return decisionDate;
}

Future<List<CalendarEvents>> getEvents() async {
  const url = 'https://data.riksdagen.se/kalender/?org=kamm&utformat=xml';

  try {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<CalendarEvents?> events = parseXml(response.body);

      return events
          .where((event) => event != null)
          .cast<CalendarEvents>()
          .toList();
    } else {
      print('Failed to load data: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('HTTP request error: $e');
    return [];
  }
}
