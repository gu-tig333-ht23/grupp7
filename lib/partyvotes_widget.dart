import 'package:flutter/material.dart';
import 'package:template/theme.dart';


class PartyInfo {
  var partyImage;
  final String votesNum;
  final String votesMajority;
  final Color partyColor;

  PartyInfo(
      this.partyImage, this.votesNum, this.votesMajority, this.partyColor);
}

List<PartyInfo> parties = [
  PartyInfo('assets/images/socialdemokraterna.png', '17', 'NEJ',
      AppColors.socialdemokraternaRed),
  PartyInfo(
      'assets/images/moderaterna.png', '15', 'JA', AppColors.moderaternaBlue),
  PartyInfo('assets/images/sverigedemokraterna', '12', 'JA',
      AppColors.sverigedemokraternaBlue),
];

class PartyVotes extends StatelessWidget {
  PartyVotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 5),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: AppColors.socialdemokraternaRed,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 25),
                child: Container(
                  child: Image.asset('assets/images/socialdemokraterna.png',
                      width: 50, height: 50),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: 150,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Röster',
                            style: AppFonts.normalTextBlack,
                          ),
                          Text(
                            '17',
                            style: AppFonts.headerBlack,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Majoritetsröst',
                            style: AppFonts.normalTextBlack,
                          ),
                          Text(
                            'NEJ',
                            style: AppFonts.headerRed,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
            ],
            //Text('Röster'), Text('Majoritets resultat')
          ),
        ),
      ),
    );
  }
}
