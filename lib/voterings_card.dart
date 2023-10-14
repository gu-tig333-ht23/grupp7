import 'package:flutter/material.dart';
import 'theme.dart';

class Voteringar extends StatelessWidget {
  // Can be used for UPCOMING votes/voteringar
  final String identification;
  final String title;
  final String decisionDate;
  final String
      isAccepted; // To display whether the proposition was accepted or rejected

  Voteringar(
      {required this.identification,
      required this.title,
      required this.decisionDate,
      required this.isAccepted,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 10, left: 10),
              decoration: BoxDecoration(
                border: Border.all(
                    style: BorderStyle.solid,
                    color: AppColors.yellow,
                    width: 1.8),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ],
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(identification, style: AppFonts.title),
                          Text(title, style: AppFonts.normalTextWhite),
                          Text('Beslut $decisionDate',
                              style: AppFonts.smallText)
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Icon(
                      Icons
                          .radio_button_checked, // You can set a default icon here if none of the conditions match.
                      color: isAccepted == 'Ja'
                          ? AppColors.green
                          : isAccepted == 'Nej'
                              ? AppColors.red
                              : isAccepted == 'Avstår'
                                  ? AppColors.purple
                                  : isAccepted == 'Frånvarande'
                                      ? AppColors.blue
                                      : AppColors
                                          .black, // Set appropriate colors for each condition.
                    ),
                  )
                ],
              ),
            ),
            Divider(),
          ],
        ));
  }
}
