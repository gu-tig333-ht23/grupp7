import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/api_votering.dart';
import '../class_votering.dart';
import '../provider/provider_ledamot.dart';
import '../voterings_card.dart';

class LedamotVyRostLista extends StatefulWidget {
  @override
  _LedamotVyRostListaState createState() => _LedamotVyRostListaState();
}

class _LedamotVyRostListaState extends State<LedamotVyRostLista> {
  List<voteringar> getUniqueTiles(List<voteringar> list) {
    Set<String> uniqueSignatures = Set();
    List<voteringar> uniqueList = [];

    for (var item in list) {
      String signature = "${item.rm}-${item.beteckning}";
      if (!uniqueSignatures.contains(signature)) {
        uniqueSignatures.add(signature);
        uniqueList.add(item);
      }
    }
    return uniqueList;
  }

  int startIndex = 0;
  int endIndex = 5;

  void showNextItems() {
    setState(() {
      startIndex += 5;
      endIndex = startIndex + 5;
    });
  }

  void showPreviousItems() {
    setState(() {
      startIndex -= 5;
      endIndex = startIndex + 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<voteringar> theList = context.watch<ProviderLedamot>().theList;
    final List cleanList = getUniqueTiles(theList);
    return Container(
      height: 400, // Set the height as per your design requirements
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:
                  endIndex <= cleanList.length ? endIndex : cleanList.length,
              itemBuilder: (context, index) {
                return FutureBuilder<Map<String, String>?>(
                  future: fetchAndParseXML(cleanList[index].voteringUrlXml),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Voteringar(
                          identification: '',
                          title: '',
                          decisionDate: '',
                          isAccepted: '',
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return ListTile(
                        title: Text("Error: ${snapshot.error}"),
                      );
                    }

                    String titel = snapshot.data?['title'] ?? "N/A";
                    String rawDatum = snapshot.data?['datum'] ?? "N/A";
                    String datum = (rawDatum != null && rawDatum.length >= 10)
                        ? rawDatum.substring(0, 10)
                        : rawDatum;

                    return Voteringar(
                        identification: cleanList[index].beteckning,
                        title: titel,
                        decisionDate: datum,
                        isAccepted: cleanList[index].rost);
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (startIndex > 0)
                ElevatedButton(
                  onPressed: showPreviousItems,
                  child: Text("Previous"),
                ),
              if (endIndex < cleanList.length)
                ElevatedButton(
                  onPressed: showNextItems,
                  child: Text("Next"),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
