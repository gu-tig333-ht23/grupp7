import 'package:flutter/material.dart';
import '../theme.dart';
import '../provider/provider_infoview.dart';
import 'package:provider/provider.dart';
import '../api/api_infoview/api_single_votes.dart';
import '../screens/info_view.dart';
import '.././provider/provider_infoview.dart';

class Voteringar extends StatelessWidget {
  final String identification;
  final String title;
  final String subTitle;
  final String decisionDate;
  final String isAccepted;

  Voteringar(
      {required this.identification,
      required this.title,
      required this.subTitle,
      required this.decisionDate,
      required this.isAccepted,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
      child: GestureDetector(
        onTap: () {
          context.read<ProviderInfoView>().toInfoview(
              beteckning: identification,
              title: title,
              context: context,
              goBack: true);
        },
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
                          Text(identification + ' ' + title,
                              style: AppFonts.title),
                          Text(subTitle, style: AppFonts.normalTextWhite),
                          Text('Beslut $decisionDate',
                              style: AppFonts.smallText)
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Icon(
                      Icons.radio_button_checked,
                      color: isAccepted == 'Ja'
                          ? AppColors.green
                          : isAccepted == 'Nej'
                              ? AppColors.red
                              : isAccepted == 'Avstår'
                                  ? AppColors.yellow
                                  : isAccepted == 'Frånvarande'
                                      ? AppColors.blue
                                      : AppColors.black,
                    ),
                  )
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
