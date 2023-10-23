import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:template/api/api_infoview/api_single_votes.dart';
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
    return FutureBuilder(
      future: _initializeData(
          context), // Add a function to initialize your data asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Data is loaded, show the page
          return _buildPartyView(context);
        } else {
          // Data is still loading, show a loading indicator
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> _initializeData(BuildContext context) async {
    String selection = context.read<PartyViewState>().selectedParty;
    var beteckning = context.read<ProviderInfoView>().beteckning;
    var punkt = context.read<ProviderInfoView>().punkt;
    await context.read<PartyViewState>().fetchPartyMembers(selection);

    await context
        .read<PartyViewState>()
        .fetchPartyMemberVotes(selection, beteckning, punkt);

    await context.read<PartyViewState>().setPunktTitle(beteckning, punkt);
  }

  Widget _buildPartyView(BuildContext context) {
    final partyViewState = context.watch<PartyViewState>();

    final String selectedParty = context.watch<PartyViewState>().selectedParty;

    var selectedTitle = context
        .watch<ProviderInfoView>()
        .title; // gets title from selected proposal

    final partiLedareList = context.watch<PartyViewState>().partiLedareList;

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
            Text(
              selectedTheme.name,
              style: AppFonts.headerBlack.copyWith(
                color: Colors.white,
              ),
            ),
            selectedTheme.assetImage.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        selectedTheme.assetImage,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
        backgroundColor: selectedTheme.color,
        leadingWidth: 30,
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
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
                          buildPartyLeaderImages(context),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: partiLedareList
                                    .map(
                                      (partiLedare) => Text(
                                        '${partiLedare.tilltalsnamn ?? ''} ${partiLedare.efternamn ?? ''}',
                                      ),
                                    )
                                    .toList(),
                              ),
                              //Text(
                              //  '${context.watch<PartyViewState>().partiLedare?.tilltalsnamn ?? ''} ${context.watch<PartyViewState>().partiLedare?.efternamn ?? ''}',
                              //),
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
                        titel:
                            'Resultat för punkt ${context.watch<ProviderInfoView>().punkt}: ${context.watch<PartyViewState>().punktTitle}',
                        ja: context.watch<PartyViewState>().PieChartValues[0],
                        nej: context.watch<PartyViewState>().PieChartValues[1],
                        avstar:
                            context.watch<PartyViewState>().PieChartValues[2],
                        franvarande:
                            context.watch<PartyViewState>().PieChartValues[3],
                      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
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
                width: 2.0, // Outline width
              ),
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Expanded(
                    child: Text(
                      ledamot.namn,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.circle,
                            color: getVoteColor(ledamot.vote)),
                      ),
                    ],
                  ),
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

Widget buildPartyLeaderImages(BuildContext context) {
  final partiLedareList = context.watch<PartyViewState>().partiLedareList;

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

Color getVoteColor(String vote) {
  // Customize this function based on your specific logic
  if (vote == 'Ja') {
    return AppColors.green;
  } else if (vote == 'Nej') {
    return AppColors.red;
  } else if (vote == 'Avstår') {
    return AppColors.yellow; // Default color for other cases
  } else if (vote == 'Frånvarande') {
    return AppColors.blue;
  } else {
    return AppColors.black;
  }
  ;
}
