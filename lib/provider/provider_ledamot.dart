import 'package:flutter/material.dart';
import '../models/model_ledamotview_votering.dart';
import '../api/api_ledamotview/api_ledarmot_vy_votering.dart';
import '../api/api_ledamotview/api_ledarmot_vy_ledarmot.dart';
import '.././models/model_ledarmot_info.dart';
import '.././api/api_get_title_from_xml.dart';

class ProviderLedamot extends ChangeNotifier {
  List<voteringar> _list = [];
  double antalJa = 25;
  double antalNej = 25;
  double antalAvstar = 25;
  double antalFranvarande = 25;
  var _ledamotInfo = LedamotInfo(
    imageUrl: '',
    ledamotNamn: '',
    ledamotStatus: '',
    ledamotParti: '',
  );

  String iid = '051207517226';

  Map antalSvarMap = {
    'antalJa': 25.0,
    'antalNej': 25.0,
    'antalAvstar': 25.0,
    'antalFranvarande': 25.0,
  };

  List<voteringar> get theList => _list;

  void setStat(List<voteringar>? voteList) {
    int antalTotal = 0;

    double ledarmotAntal(rostTyp) {
      List svarLista = _list;
      double antalSvar = 0;

      svarLista.forEach((element) {
        if (element.rost == rostTyp) {
          antalSvar += 1;
        }
      });
      print('$rostTyp $antalSvar');
      return antalSvar;
    }

    antalTotal = voteList?.length ?? 1;
    antalJa =
        antalTotal == 0 ? 0 : ((100 / antalTotal) * (ledarmotAntal('Ja')));
    antalNej =
        antalTotal == 0 ? 0 : ((100 / antalTotal) * (ledarmotAntal('Nej')));
    antalAvstar =
        antalTotal == 0 ? 0 : ((100 / antalTotal) * (ledarmotAntal('Avstår')));
    antalFranvarande = antalTotal == 0
        ? 0
        : ((100 / antalTotal) * (ledarmotAntal('Frånvarande')));
  }

  void setIid(String newIid) {
    iid = newIid;
    notifyListeners();
  }

  Future<List<voteringar>> getList() async {
    String antal = '1000'; //1000 = around one year

    final List<voteringar> rList = await apiGetList(iid, antal);
    _list = rList;
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

  get ledamotInfo => _ledamotInfo;

  Future<LedamotInfo> getLedarmot() async {
    try {
      Map<String, dynamic> apiResponse = await apiGetLedarmot(iid);

      _ledamotInfo = LedamotInfo.fromMap(apiResponse);

      return ledamotInfo;
    } catch (error) {
      print(error);
      throw Exception('Failed to load API response');
    }
  }
}
