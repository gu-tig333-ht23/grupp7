import 'package:flutter/material.dart';
import '../theme.dart';

Widget voteCard(context, title, decisionDate, description,
    [subtitle = '', fifth = 'default']) {
  return Padding(
    padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 10, left: 10),
          decoration: BoxDecoration(
            border: Border.all(
                style: BorderStyle.solid, color: AppColors.yellow, width: 1.8),
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
                    Text('$title: $subtitle', style: AppFonts.title),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                    ),
                    Text(description, style: AppFonts.normalTextWhite),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                    ),
                    Text('Datum: $decisionDate', style: AppFonts.smallText)
                  ],
                ),
              ),
              fifth != 'default'
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: Icon(
                        Icons.radio_button_checked,
                        color: fifth == 'Ja'
                            ? AppColors.green
                            : fifth == 'Nej'
                                ? AppColors.red
                                : fifth == 'Avstår'
                                    ? AppColors.purple
                                    : fifth == 'Frånvarande'
                                        ? AppColors.blue
                                        : AppColors.black,
                      ),
                    )
                  : SizedBox
                      .shrink(), // en tom box som inte tar upp plats eller syns
            ],
          ),
        ),
        Divider(),
      ],
    ),
  );
}
