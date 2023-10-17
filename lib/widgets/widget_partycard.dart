import 'package:flutter/material.dart';
import 'package:template/theme.dart';
import '../models/model_infoview.dart';

class PartyVotes extends StatelessWidget {
  final PartiVotering partiVotering;

  PartyVotes(this.partiVotering, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: partiVotering.partyColor,
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
                  child: Image.asset(
                      partiVotering.partyImage ??
                          'assets/images/kollkollen_logo.png',
                      width: 50,
                      height: 50),
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
                  height: 54,
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
                            partiVotering.highestValue.toString(),
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
                            partiVotering.majorityResult ?? 'None',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: partiVotering.majorityResult == 'JA'
                                  ? Colors.green
                                  : partiVotering.majorityResult == 'NEJ'
                                      ? Colors.red
                                      : Color.fromARGB(255, 35, 35, 35),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
