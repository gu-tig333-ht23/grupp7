import 'package:flutter/material.dart';
import '../models/model_ledamotview_votering.dart';
import '../api/api_ledamotview/api_ledarmot_vy_votering.dart';
import '../api/api_ledamotview/api_ledarmot_vy_ledarmot.dart';

class ProviderLedamot extends ChangeNotifier {
  List<voteringar> _list = [];
  String iid = '051207517226';

  List<voteringar> get theList => _list;

  Future<List<voteringar>> getList() async {
    final List<voteringar> rList = await apiGetList(iid, 10000);
    return rList;
  }

  Future<voteringar> setTitle(item) async {
    final String Url =
        'https://data.riksdagen.se/utskottsforslag/HA01' + item.beteckning;
    final punkt = item.punkt;

    if (item.titel == '' || item.underTitel == '') {
      final Map<String, String>? data = await fetchTitle(Url, punkt);

      if (data != null) {
        item.titel = data['title'] ?? '';
      } else {
        print('Error fetching or parsing data for URL: $Url');
      }

      if (data != null) {
        item.underTitel = data['rubrik'] ?? '';
      } else {
        print('Error fetching or parsing data for URL: $Url');
      }
    }

    return item;
  }

  Future<Map<String, dynamic>> getLedarmot() async {
    try {
      Map<String, dynamic> apiResponse = await apiGetLedarmot(iid);
      return apiResponse;
    } catch (e) {
      print(e);
      throw Exception('Failed to load API response');
    }
  }
}
