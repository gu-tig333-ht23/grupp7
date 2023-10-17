import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/provider_ledamot.dart';

class LedamotVyInfo extends StatelessWidget {
  const LedamotVyInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: context.watch<ProviderLedamot>().getLedarmot(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          String imageUrl =
              snapshot.data!['personlista']['person']['bild_url_192'];
          String ledamotNamn = snapshot.data!['personlista']['person']
                  ['tilltalsnamn'] +
              ' ' +
              snapshot.data!['personlista']['person']['efternamn'] +
              ' ' +
              snapshot.data!['personlista']['person']['parti'];
          String ledamotStatus =
              snapshot.data!['personlista']['person']['status'];
          return Column(
            children: [
              Container(
                width: 100,
                height: 100,
                child: ClipOval(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.9,
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              Text(ledamotNamn),
              Text(ledamotStatus),
            ],
          );
        });
  }
}
