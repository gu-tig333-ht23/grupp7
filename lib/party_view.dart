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
  String selectedParty = "Socialdemokraterna";

  @override
  Widget build(BuildContext context) {
    // Find the corresponding PartyAppBarTheme
    PartyAppBarTheme selectedTheme = partyList.firstWhere(
      (theme) => theme.name == selectedParty,
      orElse: () => PartyAppBarTheme(
          "Default", "", Colors.blue), // Default theme if not found
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedTheme.name, // Set the text dynamically
              style: AppFonts.title.copyWith(
                color: Colors.white, // Set text color
              ),
            ),
            SizedBox(width: 8), // Adjust the spacing between text and image
            selectedTheme.assetImage.isNotEmpty
                ? Image.asset(
                    selectedTheme.assetImage,
                    width: 40, // Adjust the size as needed
                    height: 40, // Adjust the size as needed
                    fit: BoxFit.cover,
                  )
                : Container(), // If assetImage is empty, don't show an image
          ],
        ),
        backgroundColor: selectedTheme.color,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                              "assets/images/socialdemokraterna.png"),
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
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return LedamotItem(ledamotList[index]);
                      },
                      itemCount: ledamotList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                    ),
                  ],
                ),
              ),
              //LedamotItem()
            ],
          ),
        ],
      ),
    );
  }
}

class LedamotItem extends StatelessWidget {
  // Widget to build list of ledamöter in party_view.dart depending
  // on what party is selected from infovy.dart
  final LedamotPlaceholder ledamotPlaceholder;
  LedamotItem(
    this.ledamotPlaceholder, {
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
                  ledamotPlaceholder.imageUrl,
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
              ledamotPlaceholder.name,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class LedamotPlaceholder {
  final String name;
  final String imageUrl;

  LedamotPlaceholder(this.name, this.imageUrl);
}

List<LedamotPlaceholder> ledamotList = [
  LedamotPlaceholder("Hanna Westerén",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/ed3399e1-7bce-4ea4-baf6-587f722710f5_80.jpg"),
  LedamotPlaceholder("Ardalan Shekarabi",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/b2bb1d34-0f20-4daf-b26e-8916bb911075_80.jpg"),
  LedamotPlaceholder("Adnan Dibrani",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/2eb5b5ce-2e8c-4063-a2c2-d03b50ff4c5d_80.jpg"),
  LedamotPlaceholder("Fredrik Olovsson",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/bc5c4354-fca3-4071-8096-acd9b7b1d09a_80.jpg"),
  LedamotPlaceholder("Lars Mejern Larsson",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/3badc18d-3c4a-4068-921a-b5fa8a9652d6_80.jpg"),
  LedamotPlaceholder("Gunilla Carlsson",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/11d950d5-e41f-4e94-af86-ae8a1996d81b_80.jpg"),
  LedamotPlaceholder("Kenneth G Forslund",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/f1484855-05d7-498f-8872-5a0c33ad535b_80.jpg"),
  LedamotPlaceholder("Johan Andersson",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/fff74c6c-fae3-4977-a472-cfe2b6ae257a_80.jpg"),
  LedamotPlaceholder("Petter Löberg",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/7826c819-d0da-4e4a-a16b-ffa3d8e9b155_80.jpg"),
  LedamotPlaceholder("Johan Löfstrand",
      "https://data.riksdagen.se/filarkiv/bilder/ledamot/eaf0fa85-8858-4e0e-97d8-daee0a771d1f_80.jpg"),
];

class PartyAppBarTheme {
  final String name;
  final String assetImage;
  final Color color;

  PartyAppBarTheme(this.name, this.assetImage, this.color);
}

List<PartyAppBarTheme> partyList = [
  PartyAppBarTheme("Socialdemokraterna", "assets/images/socialdemokraterna.png",
      AppColors.socialdemokraternaRed),
  PartyAppBarTheme(
      "Sverigedemokraterna",
      "assets/images/sverigedemokraterna.png",
      AppColors.sverigedemokraternaBlue),
  PartyAppBarTheme("Moderaterna", "assets/images/moderaterna.png",
      AppColors.moderaternaBlue),
  //PartyAppBarTheme("KD", "assets/images/kristdemokraterna.png", color),
  //PartyAppBarTheme("L", "assets/images/liberalerna.png", color),
  //PartyAppBarTheme("C", "assets/images/centerpartiet.png", color),
  //PartyAppBarTheme("MP", "assets/images/miljopartiet.png", color),
  //PartyAppBarTheme("V", "assets/images/vansterpartiet.png", color),
];
Color getSelectedPartyColor(selectedParty) {
  // Find the corresponding PartyAppBarTheme
  PartyAppBarTheme selectedTheme = partyList.firstWhere(
    (theme) => theme.name == selectedParty,
    orElse: () => PartyAppBarTheme(
        "Default", "", Colors.blue), // Default theme if not found
  );

  // Return the color from the selected theme
  return selectedTheme.color;
}
