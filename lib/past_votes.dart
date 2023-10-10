import 'package:flutter/material.dart';

List<Voteringar> voteringar = [
  Voteringar('2022/23 AU10', 'En fortsatt stärkt arbetslöshetsförsäkring', '2023-10-07'),
  Voteringar('2022/23 AU5', 'Arbetsrätt', '2023-09-28'),
  Voteringar('2022/23 AU5', 'Integration', '2023-09-20'),
  Voteringar('2022/23 CU7', 'Ersättningsrätt och insolvensrätt', '2023-09-07'),
  Voteringar('2021/22:FöU3', 'Riksrevisionens rapport om projektbidrag från anslag 2:4 Krisberedskap', '2023-08-23'),
];

class Voteringar extends StatelessWidget {
  String identification;
  String title;
  String decisionDate;

  Voteringar(this.identification, this.title, this.decisionDate);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          ),
        child: Column(
          children: [
            Text('ID: $identification'),
            Text('Ärende: $title'),
            Text('Beslut $decisionDate')
          ]
        ),
      )
    );
  }
}

class VoteringsVy extends StatelessWidget {
  const VoteringsVy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('Avslutade voteringar')),
            FloatingActionButton(
              onPressed: () {
                aboutAppAlert(context);
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: 500,
        child: ListView.builder(
          itemCount: voteringar.length,
          itemBuilder: (context, index) {
          return Voteringar(
            voteringar[index].identification,
            voteringar[index].title,
            voteringar[index].decisionDate,
            );
          },
        ),
      ),
    );
  }
}

Widget aboutAppAlert(context) {   // Pop-up window when user doesn't give any input in TextField
    Widget confirmButton = TextButton(child: Text('Ok'),
      onPressed: () => Navigator.pop(context),
      );
    AlertDialog alert = AlertDialog(
      title: Text('Om vår app'),
      content: Text('Vänligen notera att all data i denna app hämtas från riksdagen.se. Vi strävar efter att tillhandahålla korrekt och uppdaterad information, men vi kan inte garantera dess fullständighet eller aktualitet. Om du har frågor eller behöver ytterligare information, vänligen besök riksdagen.se för att verifiera uppgifterna. Tack för att du använder vår app!\nMed vänliga hälsningar, App Teamet'),
      actions: [confirmButton],
    );
    showDialog(context: context, builder: (BuildContext context){return alert;});
      return alert;
  }