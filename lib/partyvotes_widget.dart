import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/mystate.dart';
import 'package:template/theme.dart';

//Color

class PartyVotes extends StatelessWidget {
  PartyVotes({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 5),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: AppColors.moderaternaBlue,
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
