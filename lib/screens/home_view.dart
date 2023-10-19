import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/provider/provider_infoview.dart';
import 'package:template/screens/calendar_view.dart';
import 'package:template/widgets/widget_vote_card.dart';
import '../widgets/widget_about_app.dart';
import 'info_view.dart';
import '../theme.dart';
import '../provider/provider_homeview.dart';

class Voteringar extends StatelessWidget {
  final String identificationYear;
  final String beteckning;
  final String title;
  final String decisionDate;
  final String organ;
  String utskott;
  final int index;

  Voteringar({
    super.key,
    this.identificationYear = '',
    required this.beteckning,
    required this.title,
    required this.decisionDate,
    required this.organ,
    this.utskott = '',
    this.index = 0,
  });

  factory Voteringar.fromJson(Map<String, dynamic> json) {
    return Voteringar(
        identificationYear: json['rm'],
        beteckning: json['beteckning'],
        title: json['undertitel'],
        decisionDate: json['datum'],
        organ: json['organ']);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Voteringar selectedVote =
            context.read<ProviderHomeView>().voteringar[index];
        String selectedBeteckning = selectedVote.beteckning;
        String selectedTitle = selectedVote.title;
        context.read<ProviderInfoView>().fetchBeteckning(selectedBeteckning);
        context.read<ProviderInfoView>().fetchTitle(selectedTitle);
        context.read<ProviderInfoView>().fetchSummary(selectedBeteckning);
        context
            .read<ProviderInfoView>()
            .fetchVotingresult(); // hämtar röstresultat när vi navigerar till infovyn
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoView(),
          ),
        );
      },
      child: voteCard(context, utskott, decisionDate, title, beteckning),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var voteringar = context.watch<ProviderHomeView>().voteringar;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.lightGrey,
        title: Text('Voteringar', style: AppFonts.header),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
            child: FloatingActionButton(
              shape: CircleBorder(),
              tooltip: 'Om appen',
              backgroundColor: AppColors.lightGrey,
              onPressed: () {
                aboutAppAlert(context);
              },
              child: const Icon(Icons.info),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).copyWith().size.height,
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset('assets/images/kollkollen_logo.png',
                  width: 75, height: 75),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: voteringar.length,
                itemBuilder: (context, index) {
                  return Voteringar(
                    identificationYear: voteringar[index].identificationYear,
                    beteckning: voteringar[index].beteckning,
                    title: voteringar[index].title,
                    decisionDate: voteringar[index].decisionDate,
                    organ: voteringar[index].organ,
                    utskott: voteringar[index].utskott,
                    index: index,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarView(),
                    ),
                  );
                },
                child: Text('Kalendervy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
