import 'package:flutter/material.dart';
import '../../widgets/widget_party_view_ledamot_list.dart';
import '../../widgets/widget_voteresult_piechart.dart';
import '../provider/provider_info_view.dart';
import '../theme/theme.dart';
import 'package:provider/provider.dart';
import '../provider/provider_party_view.dart';
import '../widgets/widget_loadscreen.dart';
import '../theme/theme_party_view.dart';
import '../widgets/widget_party_view_party_leader.dart';
import '../widgets/widget_party_view_divider.dart';
import '../widgets/widget_party_view_search_field.dart';

class PartyView extends StatelessWidget {
  PartyView({super.key});

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
          return Loadscreen();
        }
      },
    );
  }

  Future<void> _initializeData(BuildContext context) async {
    String selectedYear = context.read<ProviderInfoView>().voteYear;
    String selection = context.read<ProviderPartyView>().selectedParty;
    var beteckning = context.read<ProviderInfoView>().beteckning;
    var punkt = context.read<ProviderInfoView>().punkt;

    await context
        .read<ProviderPartyView>()
        .setPunktTitle(selectedYear, beteckning, punkt);
    await context.read<ProviderPartyView>().fetchPartyMembers(selection);
    await context
        .read<ProviderPartyView>()
        .fetchPartyMemberVotes(selectedYear, selection, beteckning, punkt);
  }

  Widget _buildPartyView(BuildContext context) {
    final providerPartyView = context.watch<ProviderPartyView>();

    final String selectedParty =
        context.watch<ProviderPartyView>().selectedParty;

    final partiLedareList = context.watch<ProviderPartyView>().partiLedareList;

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
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          selectedTheme.assetImage,
                          cacheHeight: 150,
                          cacheWidth: 150,
                          fit: BoxFit.cover,
                        ),
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
                      PartyLeaderWidget(
                          selectedParty: selectedParty,
                          partiLedareList: partiLedareList,
                          selectedTheme: selectedTheme),
                      PartyViewDivider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: VoteResult(
                          titel:
                              "Partiets resultat för punkt ${context.watch<ProviderInfoView>().punkt}: ${context.watch<ProviderPartyView>().punktTitle}",
                          titleSize: 20,
                          ja: context
                              .watch<ProviderPartyView>()
                              .pieChartValues[0],
                          nej: context
                              .watch<ProviderPartyView>()
                              .pieChartValues[1],
                          avstar: context
                              .watch<ProviderPartyView>()
                              .pieChartValues[2],
                          franvarande: context
                              .watch<ProviderPartyView>()
                              .pieChartValues[3],
                        ),
                      ),
                      SearchField(
                          textEditingController: _textEditingController),
                      ListViewBuilder(
                          ledamotList: providerPartyView.ledamotResultList),
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
