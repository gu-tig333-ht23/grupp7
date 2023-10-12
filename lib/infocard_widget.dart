import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:read_more_text/read_more_text.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                        'Rubrik',
                        style: AppFonts.header,
                      ),
                      ReadMoreText(
                        'Utskottet ställer sig bakom regeringens förslag till ändringar i lagen om arbetslöshetsförsäkring. I propositionen föreslås att vissa tidigare beslutade lagändringar ska utgå och att tidigare tillfälligt beslutade bestämmelser ska gälla tills vidare. Regeringens förslag innebär att de tillfälliga lättnaderna i arbetsvillkoret och karensvillkoret inte ska upphöra att gälla, utan ska i stället gälla tills vidare. Detsamma gäller den tillfälliga möjligheten för regeringen eller den myndighet som regeringen bestämmer att meddela föreskrifter om undantag från lagens begränsning av företagares möjlighet att få arbetslöshetsersättning vid upprepade uppehåll i näringsverksamheten, den s.k. femårsregeln. Utskottet anser att riksdagen bör avslå motionsyrkandena. I betänkandet finns två reservationer (V, C) och två särskilda yttranden (S, MP)',
                        numLines: 5,
                        readMoreText: 'Visa mer',
                        readLessText: 'Visa mindre',
                        style: AppFonts.normalTextWhite,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
