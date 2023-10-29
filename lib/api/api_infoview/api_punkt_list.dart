import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> apiFetchPunktList(voteYear, beteckning) async {
  final String url =
      'https://data.riksdagen.se/voteringlista/?rm=$voteYear&bet=$beteckning&punkt=&valkrets=&rost=&iid=&sz=500&utformat=json&gruppering=bet';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;

      // Parse the JSON data
      Map<String, dynamic> jsonDataMap = json.decode(jsonData);

      // Extract the "votering" data
      var voteringData = jsonDataMap['voteringlista']['votering'];
      List<dynamic> voteringList;

      if (voteringData is List) {
        voteringList = voteringData;
      } else if (voteringData is Map) {
        voteringList = [voteringData];
      } else {
        print('Unexpected data format for "votering".');
        return [];
      }

      // Extract the "punkt" values and store them in a list
      List punktList = voteringList.map((votering) {
        return votering['punkt'];
      }).toList();

      return punktList;
    } else {
      print('Failed to get data. Error: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    print('Error: $error');
    return [];
  }
}
