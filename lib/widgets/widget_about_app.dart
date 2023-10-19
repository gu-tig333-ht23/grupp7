import 'package:flutter/material.dart';

Widget aboutAppAlert(context) {
  // Pop-up window (About the app with reference to riksdag.se)
  Widget confirmButton = TextButton(
    child: Text('Ok'),
    onPressed: () => Navigator.pop(context),
  );
  AlertDialog alert = AlertDialog(
    title: Text('Om vår app'),
    content: Text(
        'Vänligen notera att all data i denna app hämtas från riksdagen.se. Vi strävar efter att tillhandahålla korrekt och uppdaterad information, men vi kan inte garantera dess fullständighet eller aktualitet.\nOm du har frågor eller behöver ytterligare information, vänligen besök riksdagen.se för att verifiera uppgifterna.\n\nTack för att du använder vår app!\nMed vänliga hälsningar, App Teamet'),
    actions: [confirmButton],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
  return alert;
}