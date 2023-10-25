import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> apiFetchPunktList(beteckning) async {
  print('punktlist');
  final String url =
      'https://data.riksdagen.se/voteringlista/?rm=2022%2F23&bet=$beteckning&punkt=&valkrets=&rost=&iid=&sz=500&utformat=json&gruppering=bet';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      print('R:' + response.body);
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

      // Print the list of "punkt" values
      print(punktList);
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
