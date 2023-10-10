import 'package:flutter/material.dart';

List<Voteringar> voteringar = [
  Voteringar('2022/23 AU10', 'En fortsatt stärkt arbetslöshetsförsäkring', '2023-10-07', true),
  Voteringar('2022/23 AU5', 'Arbetsrätt', '2023-09-28', true),
  Voteringar('2022/23 AU5', 'Integration', '2023-09-20', false),
  Voteringar('2022/23 CU7', 'Ersättningsrätt och insolvensrätt', '2023-09-07', false),
  Voteringar('2021/22:FöU3', 'Riksrevisionens rapport om projektbidrag från anslag 2:4 Krisberedskap', '2023-08-23', true),
];

class Voteringar extends StatelessWidget {
  final String identification;
  final String title;
  final String decisionDate;
  final bool isAccepted; // To display whether the proposition was accepted or rejected

  Voteringar(this.identification, this.title, this.decisionDate, this.isAccepted, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 5),
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.solid, color: Colors.yellow, width: 1.8), // Update color!
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.4),
            ),
          ], 
          color: Colors.blue[800], // Update color!
          borderRadius: BorderRadius.circular(20),
          ),
        child: Row(
          children: [
            Expanded(child: 
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(identification),
                    Text(title),
                    Text('Beslut $decisionDate')
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Icon(
                isAccepted ? Icons.check : Icons.close, // Placeholder for icons, update later
                color: isAccepted ? Colors.green : Colors.red, // Update colors for icons
                ),
            )
          ],
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
        centerTitle: true,
        backgroundColor: Colors.blue[700], // Update color!
        title: Text('Avslutade voteringar'),
        actions: [Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
          child: FloatingActionButton(
                shape: CircleBorder(),
                tooltip: 'Om appen',
                backgroundColor: Colors.blue[700], // Update color!
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
        color: Colors.white, // Update color!
        child: ListView.builder(
          itemCount: voteringar.length,
          itemBuilder: (context, index) {
          return Voteringar(
            voteringar[index].identification,
            voteringar[index].title,
            voteringar[index].decisionDate,
            voteringar[index].isAccepted,
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
      content: Text('Vänligen notera att all data i denna app hämtas från riksdagen.se. Vi strävar efter att tillhandahålla korrekt och uppdaterad information, men vi kan inte garantera dess fullständighet eller aktualitet.\nOm du har frågor eller behöver ytterligare information, vänligen besök riksdagen.se för att verifiera uppgifterna.\n\nTack för att du använder vår app!\nMed vänliga hälsningar, App Teamet'),
      actions: [confirmButton],
    );
    showDialog(context: context, builder: (BuildContext context){return alert;});
      return alert;
  }