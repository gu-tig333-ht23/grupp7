import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/model_party_view_ledamot.dart';
import '../provider/provider_party_view.dart';
import '../theme/theme_party_view.dart';

class PartyLeaderWidget extends StatelessWidget {
  const PartyLeaderWidget({
    super.key,
    required this.selectedParty,
    required this.partiLedareList,
    required this.selectedTheme,
  });

  final String selectedParty;
  final List<Ledamot> partiLedareList;
  final PartyAppBarTheme selectedTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildPartyLeaderImages(context),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selectedParty == 'MP' ? 'Språkrör' : "Partiledare:",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: partiLedareList
                  .map(
                    (partiLedare) => Text(
                      '${partiLedare.tilltalsnamn} ${partiLedare.efternamn}',
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: "Webbplats",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(
                        Uri.parse(selectedTheme.webPage)); // Open party website
                  },
              ),
            ),
          ],
        )
      ],
    );
  }
}

Widget buildPartyLeaderImages(BuildContext context) {
  final partiLedareList = context.watch<ProviderPartyView>().partiLedareList;

  if (partiLedareList.isNotEmpty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: partiLedareList
          .map(
            (partiLedare) => ClipOval(
              child: Image.network(
                partiLedare.bildUrl80,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          )
          .toList(),
    );
  } else {
    return CircularProgressIndicator();
  }
}
