import 'package:flutter/material.dart';
import 'package:template/info_view.dart';
import './theme.dart';

List<Voteringar> voteringar = [
  Voteringar('2022/23 AU10', 'En fortsatt stärkt arbetslöshetsförsäkring', '2023-10-07', true),
  Voteringar('2022/23 AU5', 'Arbetsrätt', '2023-09-28', true),
  Voteringar('2022/23 AU5', 'Integration', '2023-09-20', false),
  Voteringar('2022/23 CU7', 'Ersättningsrätt och insolvensrätt', '2023-09-07', false),
  Voteringar('2021/22:FöU3', 'Riksrevisionens rapport om projektbidrag från anslag 2:4 Krisberedskap', '2023-08-23', true),
];

class Voteringar extends StatelessWidget { // Can be used for UPCOMING votes/voteringar
  final String identification;
  final String title;
  final String decisionDate;
  final bool isAccepted; // To display whether the proposition was accepted or rejected

  Voteringar(this.identification, this.title, this.decisionDate, this.isAccepted, {super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
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
                      Text('Beslut $decisionDate', style: AppFonts.smallText)
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Icon(
                    isAccepted ? Icons.check : Icons.close, // Placeholder for icons, update later
                    color: isAccepted ? AppColors.green : AppColors.red,
                    ),
                )
              ],
            ),
          ),
          Divider(),
        ],
      )
    );
  }
}
final List<bool> selectedVotering = <bool>[true, false];

class VoteringsVy extends StatefulWidget {
  const VoteringsVy({super.key});
  
  @override
  State<VoteringsVy> createState() => _VoteringsVyState();
}

class _VoteringsVyState extends State<VoteringsVy> {
  @override
  Widget build(BuildContext context) {


    const List<Widget> voteringsDisplay = <Widget>[
      Text('Genomförda'),
      Text('Kommande'),
    ];

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
                  return InkWell(
                    onTap: () { 
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InfoView()),
                      );
                    },
                    child: Voteringar(
                      voteringar[index].identification,
                      voteringar[index].title,
                      voteringar[index].decisionDate,
                      voteringar[index].isAccepted,
                    ), 
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 50),
              child: ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                  for (int i = 0; i < selectedVotering.length; i++) {
                      selectedVotering[i] = i == index;}
                      });
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