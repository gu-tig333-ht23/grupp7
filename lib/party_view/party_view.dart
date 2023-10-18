import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:template/ledarmot_vy/ledamot_vy.dart';
import 'package:template/party_view/party_provider.dart';
import '../theme.dart';
import 'package:url_launcher/url_launcher.dart';
//import '../ledarmot_vy/ledarmot_vy_stat_bar.dart';
import '../../provider/provider_ledamot.dart';
import 'package:provider/provider.dart';
import 'api_ledamot_list.dart';
import 'party_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PartyView extends StatelessWidget {
  final String selectedParty;
  PartyView(
      {required this.selectedParty,
      // required this.selectedProposal,
      super.key});

  String selectedProposal = "En fortsatt stärkt arbetslöshetsförsäkring";
  final TextEditingController _textEditingController = TextEditingController();

  //Future<List<Ledamot>> ledamotList = fetchLedamotList();

  @override
  Widget build(BuildContext context) {
    final partyViewState = context.watch<PartyViewState>();

    // Trigger the data fetching when the widget is built
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      partyViewState.fetchPartyMembers(selectedParty);
    });
    // Find the corresponding PartyAppBarTheme
    PartyAppBarTheme selectedTheme = partyList.firstWhere(
      (theme) => theme.id == selectedParty,
      orElse: () => PartyAppBarTheme(
          "", "Default", "", Colors.blue, ""), // Default theme if not found
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedTheme.assetImage.isNotEmpty
                ? Image.asset(
                    selectedTheme.assetImage,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  )
                : Container(),
            SizedBox(width: 15),
            Text(
              selectedTheme.name,
              style: AppFonts.title.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: selectedTheme.color,
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  fetchPlaceHolder();
          print(partyViewState.ledamotList.length);
        },
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      //Row(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      //  children: [
                      //    SizedBox(
                      //      height: 60,
                      //      width: 60,
                      //      child: Image.asset(
                      //          "assets/images/socialdemokraterna.png"),
                      //    ),
                      //    Text(
                      //      "Socialdemokraterna",
                      //      style: AppFonts.headerRed,
                      //    )
                      //  ],
                      //),

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
                                  text: selectedTheme.webPage,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse(selectedTheme
                                          .webPage)); // Open party website
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
                        "Partiets reslutat i frågan: $selectedProposal.",
                        textAlign: TextAlign.center,
                      ),
                      //LedamotVyStatBar(
                      //    theList: context.watch<ProviderLedamot>().theList),
                      //Padding(
                      //  padding: const EdgeInsets.all(8.0),
                      //  child: Divider(
                      //    thickness: 1,
                      //    color: Colors.black,
                      //  ),
                      //),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                              labelText: "  Sök ledamot",
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0), //
                              ),
                              suffixIcon: Icon(Icons.search),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 4) //
                              ),
                        ),
                      ),
                      ListViewBuilder(ledamotList: partyViewState.ledamotList),
                    ],
                  ),
                ),
                //LedamotItem()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    super.key,
    required this.ledamotList,
  });

  final List<Ledamot> ledamotList;

  @override
  Widget build(BuildContext context) {
    final List<Ledamot> ledamotList =
        context.watch<PartyViewState>().ledamotList;
    final itemCount = ledamotList.length;

    return ListView.builder(
      itemBuilder: (context, index) {
        return LedamotItem(ledamotList[index]);
      },
      itemCount: itemCount,
      shrinkWrap: true,
      physics: ScrollPhysics(),
    );
  }
}

class LedamotItem extends StatelessWidget {
  // Widget to build list of ledamöter in party_view.dart depending
  // on what party is selected from infovy.dart

  final Ledamot ledamot;

  LedamotItem(
    this.ledamot, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String fullName = '${ledamot.tilltalsnamn} ${ledamot.efternamn}';
    final String imageUrl = ledamot.bildUrl80;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            print('hejhopp');
            //MaterialPageRoute(builder: (context) => LedamotVy(ledamot.intressentId));
          },
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
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  fullName,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ));
  }
}

class PartyAppBarTheme {
  final String id;
  final String name;
  final String assetImage;
  final Color color;
  final String webPage;

  PartyAppBarTheme(
      this.id, this.name, this.assetImage, this.color, this.webPage);
}

List<PartyAppBarTheme> partyList = [
  PartyAppBarTheme(
      "S",
      "Socialdemokraterna",
      "assets/images/socialdemokraterna.png",
      AppColors.socialdemokraternaRed,
      "https://www.socialdemokraterna.se"),
  PartyAppBarTheme(
      "SD",
      "Sverigedemokraterna",
      "assets/images/sverigedemokraterna.png",
      AppColors.sverigedemokraternaBlue,
      "https://www.sverigedemokraterna.se"),
  PartyAppBarTheme("M", "Moderaterna", "assets/images/moderaterna.png",
      AppColors.moderaternaBlue, "https://www.moderaterna.se"),
  //PartyAppBarTheme("KD", "assets/images/kristdemokraterna.png", color),
  //PartyAppBarTheme("L", "assets/images/liberalerna.png", color),
  //PartyAppBarTheme("C", "assets/images/centerpartiet.png", color),
  //PartyAppBarTheme("MP", "assets/images/miljopartiet.png", color),
  //PartyAppBarTheme("V", "assets/images/vansterpartiet.png", color),
];
