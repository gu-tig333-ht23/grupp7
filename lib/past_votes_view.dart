import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './info_view.dart';
import './theme.dart';
import 'provider/provider_voteringsvy.dart';

class Voteringar extends StatelessWidget {
  final String identification;
  final String rm;
  final String beteckning;
  final String title;
  final String decisionDate;
  final int index;
  //final bool isAccepted;

  Voteringar({super.key, 
    required this.identification,
    required this.rm,
    required this.beteckning, 
    required this.title, 
    required this.decisionDate, 
    this.index = 0, 
    //required this.isAccepted - Haven't found the identifier for accepted decisions yet 
    });

  factory Voteringar.fromJson(Map<String, dynamic> json) {
    return Voteringar(
      identification: json['rm'] + ': ' + json['beteckning'], 
      rm: json['rm'],
      beteckning: json['beteckning'],
      title: json['undertitel'], 
      decisionDate: json['datum']); 
      //isAccepted: json['isAccepted']
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoView(
              //voteringar: context.read<ProviderVoteringsVy>().voteringar[index],
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 10, left: 10),
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid, color: AppColors.yellow, width: 1.8),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ], 
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(20),
                ),
              child: Row(
                children: [
                  Expanded(child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(identification, style: AppFonts.title),
                        Text(title, style: AppFonts.normalTextWhite),
                        Text('Beslut: $decisionDate', style: AppFonts.smallText)
                      ]
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Icon(
                      isAccepted ? Icons.check : Icons.close, // Placeholder for icons, update later
                      color: isAccepted ? AppColors.green : AppColors.red,
                      ),
                  )*/
                ],
              ),
            ),
            Divider(),
          ],
        )
      ),
    );
  }
}

class VoteringsVy extends StatelessWidget {
  const VoteringsVy({super.key});

  @override
  Widget build(BuildContext context) {
    var voteringar = context.watch<ProviderVoteringsVy>().voteringar;
    var voteringsDisplay = context.watch<ProviderVoteringsVy>().voteringsDisplay;
    var selectedVotering = context.watch<ProviderVoteringsVy>().selectedVotering;

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
              child: const Icon(Icons.info)
            ),
          ),
        ]
      ),
      body: Container(
        height: MediaQuery.of(context).copyWith().size.height,
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset('assets/images/kollkollen_logo.png', width: 75, height: 75),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: voteringar.length,
                itemBuilder: (context, index) {
                  return Voteringar(
                    identification: voteringar[index].identification,
                    rm: voteringar[index].rm,
                    beteckning: voteringar[index].beteckning,
                    title: voteringar[index].title,
                    decisionDate: voteringar[index].decisionDate,
                    index: index,
                    //isAccepted: voteringar[index].isAccepted,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 50),
              child: ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  context.read<ProviderVoteringsVy>().getSelectedVotering(index);
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: AppColors.darkGrey,
                selectedColor: AppColors.lightGrey,
                fillColor: AppColors.mediumGrey,
                color: AppColors.black,
                constraints: const BoxConstraints(
                  minHeight: 40,
                  minWidth: 100,
                ),
                isSelected: selectedVotering,
                children: voteringsDisplay,
              )
            )
          ]
        ),
      ),
    );
  }
}

Widget aboutAppAlert(context) {   // Pop-up window (About the app with reference to riksdag.se)
    Widget confirmButton = TextButton(child: Text('Ok'),
      onPressed: () => Navigator.pop(context),
      );
    AlertDialog alert = AlertDialog(
      title: Text('Om vår app'),
      content: Text('Vänligen notera att all data i denna app hämtas från riksdagen.se. Vi strävar efter att tillhandahålla korrekt och uppdaterad information, men vi kan inte garantera dess fullständighet eller aktualitet.\nOm du har frågor eller behöver ytterligare information, vänligen besök riksdagen.se för att verifiera uppgifterna.\n\nTack för att du använder vår app!\nMed vänliga hälsningar, App Teamet'),
      actions: [confirmButton],
    );
    showDialog(context: context, builder: (BuildContext context){return alert;});
      return alert;
  }