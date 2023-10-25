import 'package:flutter/material.dart';
import 'package:template/theme/theme.dart';

Widget aboutAppAlert(context) {
  // Pop-up window (About the app with reference to riksdag.se)
  Widget confirmButton = TextButton(
    child: Text('Ok'),
    onPressed: () => Navigator.pop(context),
  );
  AlertDialog alert = AlertDialog(
    title: Text('Om vår app'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            'Vänligen notera att all data i denna app hämtas från riksdagen.se. Vi strävar efter att tillhandahålla korrekt och uppdaterad information, men vi kan inte garantera dess fullständighet eller aktualitet.\n\nOm du har frågor eller behöver ytterligare information, vänligen besök riksdagen.se för att verifiera uppgifterna.\n'),
        Divider(color: AppColors.black),
        Text(
            '\nAvslutade voteringar presenterar vilket utskott som har presenterat förslaget, vad beslutet innehåller och vilket datum röstningen inträffade. För att veta mer om en specifik votering klickar du på önskad votering.\n\nDet finns även en knapp i övre vänstra hörnet där du kan läsa om kommande händelser i kammaren.\n\nTack för att du använder vår app!\nMed vänliga hälsningar, App Teamet'),
      ],
    ),
    actions: [confirmButton],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
  return alert;
}
