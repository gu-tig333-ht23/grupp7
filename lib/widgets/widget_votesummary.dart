import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:template/provider/provider_infoview.dart';
import '../theme.dart';
//import 'package:read_more_text/read_more_text.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    var title =
        context.watch<ProviderInfoView>().title; // Titeln på summeringskortet
    var summary = context
        .watch<ProviderInfoView>()
        .summary; // Summeringen hämtad från HTML
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 5),
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
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
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFonts.header,
                    ),
                    Divider(color: AppColors.backgroundColor),
                    Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: ReadMoreText(
                        summary,
                        trimMode: TrimMode.Line,
                        trimLines: 5,
                        trimCollapsedText: 'Visa mer',
                        trimExpandedText: 'Visa mindre',
                        style: AppFonts.normalTextWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
