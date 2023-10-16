import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ledarmot_vy/ledarmot_vy_stat_bar.dart';
import '../provider/provider_ledamot.dart';
import 'package:provider/provider.dart';

class PartyView extends StatelessWidget {
  PartyView({super.key});

  String partyWebPage = "https://www.socialdemokraterna.se";
  final Uri partyUrl = Uri.parse("https://www.socialdemokraterna.se");
  String proposal = "En fortsatt stärkt arbetslöshetsförsäkring";
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Partivy",
          style: AppFonts.title,
        ),
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset("assets/images/socialdemokraterna.png"),
                  ),
                  Text(
                    "Socialdemokraterna",
                    style: AppFonts.headerRed,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // lägg till bild på partiledare här
                  ClipOval(
                    child: Image.network(
                      'https://data.riksdagen.se/filarkiv/bilder/ledamot/dcc2ab7d-3fc1-4a28-b3c7-be1679c047b3_80.jpg',
                      width: 60, // Adjust the size as needed
                      height: 60, // Adjust the size as needed
                      fit: BoxFit.cover,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Partiledare:",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Magdalena Andersson"),
                      SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: partyWebPage,
                          style: TextStyle(
                            color: Colors.blue, // Set the hyperlink color
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Implement the action you want when the link is tapped
                              launchUrl(partyUrl);
                            },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Text(
                "Partiets reslutat i frågan: $proposal.",
                textAlign: TextAlign.center,
              ),
              LedamotVyStatBar(
                  theList: context.watch<ProviderLedamot>().theList),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      labelText: "Sök ledamot",
                      filled: true,
                      fillColor: Colors.grey[200], // Background color
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded edges
                      ),
                      suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 4) // Search icon to the right
                      ),
                ),
              ),
              LedamotItem()
            ],
          ),
        ),
      ),
    );
  }
}

class LedamotItem extends StatelessWidget {
  // Widget to build list of ledamöter in party_view.dart depending
  // on what party is selected from infovy.dart
  const LedamotItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          border: Border.all(
            color: AppColors.yellow, // Outline color
            width: 1.0, // Outline width
          ),
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipOval(
                child: Image.network(
                  'https://data.riksdagen.se/filarkiv/bilder/ledamot/dcc2ab7d-3fc1-4a28-b3c7-be1679c047b3_80.jpg',
                  width: 60, // Adjust the size as needed
                  height: 60, // Adjust the size as needed
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              "Hanna Westerén",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class LedamotPlaceholder {}
