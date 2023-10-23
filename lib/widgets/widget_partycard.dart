import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/party_view/party_view.dart';
import 'package:template/theme.dart';
import '../models/model_infoview.dart';
import '../party_view/party_provider.dart';
import '../provider/provider_infoview.dart';

class PartyVotes extends StatelessWidget {
  double voteBallSize = 50;

  String parti;
  String antalJa;
  String antalNej;
  String antalFr;
  String antalAvs;
  var partiColor;
  var partyImage;

  PartyVotes({
    required this.parti,
    required this.antalJa,
    required this.antalNej,
    required this.antalFr,
    required this.antalAvs,
    required this.partiColor,
    required this.partyImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
      child: GestureDetector(
        onTap: () {
          context.read<PartyViewState>().setSelectedParty(parti);
          context
              .read<PartyViewState>()
              .setPieChartValues(antalJa, antalNej, antalFr, antalAvs);

          String selection = context.read<PartyViewState>().selectedParty;
          context.read<PartyViewState>().fetchPartyMembers(selection);
          var beteckning = context.read<ProviderInfoView>().beteckning;
          var punkt = context.read<ProviderInfoView>().punkt;
          context
              .read<PartyViewState>()
              .fetchPartyMemberVotes(selection, beteckning, punkt);

          context.read<PartyViewState>().setPunktTitle(beteckning, punkt);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PartyView()));
        },
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
            color: partiColor,
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
                        partyImage ?? 'assets/images/kollkollen_logo.png',
                        width: 50,
                        height: 50),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Color of the border
                            width: 2.0, // Width of the border
                          ),
                          borderRadius: BorderRadius.circular(voteBallSize),
                          color: Colors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.green, // Color of the border
                              width: 2.0, // Width of the border
                            ),
                            borderRadius: BorderRadius.circular(voteBallSize),
                            color: Colors.white,
                          ),
                          width: voteBallSize,
                          height: voteBallSize,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$antalJa',
                                style: TextStyle(
                                    color: AppColors.green, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Color of the border
                            width: 2.0, // Width of the border
                          ),
                          borderRadius: BorderRadius.circular(voteBallSize),
                          color: Colors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.red, // Color of the border
                              width: 2.0, // Width of the border
                            ),
                            borderRadius: BorderRadius.circular(voteBallSize),
                            color: Colors.white,
                          ),
                          width: voteBallSize,
                          height: voteBallSize,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$antalNej',
                                style: TextStyle(
                                    color: AppColors.red, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Color of the border
                            width: 2.0, // Width of the border
                          ),
                          borderRadius: BorderRadius.circular(voteBallSize),
                          color: Colors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.yellow, // Color of the border
                              width: 2.0, // Width of the border
                            ),
                            borderRadius: BorderRadius.circular(voteBallSize),
                            color: Colors.white,
                          ),
                          width: voteBallSize,
                          height: voteBallSize,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$antalAvs',
                                style: TextStyle(
                                    color: AppColors.yellow, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Color of the border
                            width: 2.0, // Width of the border
                          ),
                          borderRadius: BorderRadius.circular(voteBallSize),
                          color: Colors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.blue, // Color of the border
                              width: 2.0, // Width of the border
                            ),
                            borderRadius: BorderRadius.circular(voteBallSize),
                            color: Colors.white,
                          ),
                          width: voteBallSize,
                          height: voteBallSize,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$antalFr',
                                style: TextStyle(
                                    color: AppColors.blue, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
