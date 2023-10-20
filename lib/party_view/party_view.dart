import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:template/widgets/widget_voteresult_piechart.dart';
import '../provider/provider_homeview.dart';
import '../provider/provider_infoview.dart';
import '../screens/home_view.dart';
import '../screens/ledarmot_vy/ledamot_vy.dart';
import '../theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'api_ledamot_list.dart';
import 'party_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../provider/provider_ledamot.dart';

class PartyView extends StatelessWidget {
  PartyView(
      {
      // required this.selectedProposal,
      super.key});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final partyViewState = context.watch<PartyViewState>();

    final String selectedParty = context.watch<PartyViewState>().selectedParty;

    var selectedTitle = context
        .watch<ProviderInfoView>()
        .title; // gets title from selected proposal

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

          var partySInstances = context
              .read<ProviderInfoView>()
              .getPartiVoteringForParty(selectedParty);
          print(partySInstances);

          print(_textEditingController.text);
          print("hej");
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildPartyLeaderImage(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedParty == 'MP'
                                    ? 'Språkrör'
                                    : "Partiledare:",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${context.watch<PartyViewState>().partiLedare?.tilltalsnamn ?? ''} ${context.watch<PartyViewState>().partiLedare?.efternamn ?? ''}',
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
                        "Partiets reslutat i frågan: $selectedTitle.",
                        textAlign: TextAlign.center,
                      ),
                      VoteResult(
                          ja: context
                              .read<ProviderInfoView>()
                              .getPartiVoteringForParty(selectedParty)
                              .fold(
                                  0, (sum, vote) => sum + int.parse(vote.yes)),
                          nej: context
                              .read<ProviderInfoView>()
                              .getPartiVoteringForParty(selectedParty)
                              .fold(0, (sum, vote) => sum + int.parse(vote.no)),
                          avstar: context
                              .read<ProviderInfoView>()
                              .getPartiVoteringForParty(selectedParty)
                              .fold(
                                  0, (sum, vote) => sum + int.parse(vote.pass)),
                          franvarande: context
                              .read<ProviderInfoView>()
                              .getPartiVoteringForParty(selectedParty)
                              .fold(
                                  0,
                                  (sum, vote) =>
                                      sum + int.parse(vote.abscent))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _textEditingController,
                          onChanged: (searchTerm) {
                            print('changed');
                            context.read<PartyViewState>().getLedamotListSearch(
                                _textEditingController.text);
                          },
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
                      ListViewBuilder(
                          ledamotList: partyViewState.ledamotResultList),
                    ],
                  ),
                ),
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

  final List<LedamotResult> ledamotList;

  @override
  Widget build(BuildContext context) {
    final List<LedamotResult> ledamotList =
        context.watch<PartyViewState>().ledamotResultList;

    // Group the list by 'namn'
    final Map<String, List<LedamotResult>> groupedByName =
        groupByName(ledamotList);

    // Flatten the grouped data to create a list for the ListView
    final List<Widget> items = [];

    groupedByName.forEach((namn, results) {
      items.add(
        Column(
          children: [
            LedamotItem(results.first), // Display the common 'namn' and 'image'
            for (var result in results)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Punkt ${result.punkt}: ${result.vote}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });

    return ListView(
      children: items,
      shrinkWrap: true,
      physics: ScrollPhysics(),
    );
  }

  Map<String, List<LedamotResult>> groupByName(
      List<LedamotResult> ledamotList) {
    Map<String, List<LedamotResult>> groupedMap = {};

    for (var result in ledamotList) {
      if (groupedMap.containsKey(result.namn)) {
        groupedMap[result.namn]!.add(result);
      } else {
        groupedMap[result.namn] = [result];
      }
    }

    return groupedMap;
  }
}

class LedamotItem extends StatelessWidget {
  // Widget to build list of ledamöter in party_view.dart depending
  // on what party is selected from infovy.dart

  final LedamotResult ledamot;

  LedamotItem(
    this.ledamot, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PartyViewState partyViewState = context.watch<PartyViewState>();
    //final String fullName = '${ledamot.tilltalsnamn} ${ledamot.efternamn}';
    final Ledamot ledamotImage =
        partyViewState.findLedamotByIntressentId(ledamot.intressentId);

    final String imageUrl = ledamotImage.bildUrl80;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: GestureDetector(
          // Set iid for provider_ledamot and jump to page LedamotVy
          onTap: () {
            context.read<ProviderLedamot>().setIid(ledamot.intressentId);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LedamotVy()));
            print(ledamot.intressentId);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        ledamot.namn,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Punkt ${ledamot.punkt}: ${ledamot.vote}",
                            style: AppFonts.normalTextWhite,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
  PartyAppBarTheme("S", "Socialdemokraterna", AppImages.imageSocialdemokraterna,
      AppColors.socialdemokraternaRed, "https://www.socialdemokraterna.se"),
  PartyAppBarTheme(
      "SD",
      "Sverigedemokraterna",
      "assets/images/sverigedemokraterna.png",
      AppColors.sverigedemokraternaBlue,
      "https://www.sverigedemokraterna.se"),
  PartyAppBarTheme("M", "Moderaterna", AppImages.imageModeraterna,
      AppColors.moderaternaBlue, "https://www.moderaterna.se"),
  PartyAppBarTheme("KD", "Kristdemokraterna", AppImages.imageKristdemokraterna,
      AppColors.kristdemokraternaBlue, "https://www.kristdemokraterna.se"),
  PartyAppBarTheme("L", "Liberalerna", AppImages.imageLiberalerna,
      AppColors.liberalernaBlue, "https://www.liberalerna.se"),
  PartyAppBarTheme("C", "Centerpartiet", AppImages.imageCenterpartietWhite,
      AppColors.centerpartietGreen, "https://www.centerpartiet.se"),
  PartyAppBarTheme("MP", "Miljöpartiet de gröna", AppImages.imageMiljopartiet,
      AppColors.miljopartietGreen, "https://www.mp.se"),
  PartyAppBarTheme("V", "Vänsterpartiet", AppImages.imageVansterpartiet,
      AppColors.vansterpartietRed, "https://www.vansterpartiet.se"),
];

Widget buildPartyLeaderImage(BuildContext context) {
  final partiLedare = context.watch<PartyViewState>().partiLedare;

  if (partiLedare != null) {
    return ClipOval(
      child: Image.network(
        partiLedare.bildUrl80,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  } else {
    return CircularProgressIndicator();
  }
}
