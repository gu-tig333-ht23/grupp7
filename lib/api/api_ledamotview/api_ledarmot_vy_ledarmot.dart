import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding

Future<Map<String, dynamic>> apiGetLedarmot(iid) async {
  final String _iid = iid;
  final String url =
      "https://data.riksdagen.se/personlista/?iid=$_iid&fnamn=&enamn=&f_ar=&kn=&parti=&valkrets=&rdlstatus=&org=&utformat=json&sort=sorteringsnamn&sortorder=asc&termlista=";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data from the API');
  }
}
