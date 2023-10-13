import 'package:flutter/material.dart';
import '../class_votering.dart';
import '../api/api_votering.dart';
import '../api/api_ledarmot.dart';

class ProviderLedamot extends ChangeNotifier {
  List<voteringar> _list = [];
  String iid = '051207517226';

  List get list => _list;

  ProviderLedamot() {
    getList().then((result) {
      _list = result;
      notifyListeners();
    });
  }

  List<voteringar> get theList => _list;

  Future<List<voteringar>> getList() async {
    final List<voteringar> rList = await apiGetList(iid);
    return rList;
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
