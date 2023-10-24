import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/screens/party_view/party_view.dart';
import 'package:template/theme.dart';
import 'package:template/widgets/wiget_ball.dart';
import '../models/model_infoview.dart';
import '../provider/provider_party_view.dart';
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
          context.read<ProviderPartyView>().setSelectedParty(parti);
          context.read<ProviderPartyView>().setPieChartValues(
                antalJa,
                antalNej,
                antalAvs,
                antalFr,
              );

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 25),
                  child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        partyImage ?? 'assets/images/kollkollen_logo.png',
                        cacheHeight: 150,
                        cacheWidth: 150,
                      )
                      //Image(
                      //    image: ResizeImage(
                      //  AssetImage(
                      //      partyImage ?? 'assets/images/kollkollen_logo.png'),
                      //  width: 150,
                      //  height: 150,
                      //))
                      ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BallWidget(
                          voteBallSize: voteBallSize,
                          statusColor: AppColors.green,
                          antal: antalJa),
                      BallWidget(
                          voteBallSize: voteBallSize,
                          statusColor: AppColors.red,
                          antal: antalNej),
                      BallWidget(
                          voteBallSize: voteBallSize,
                          statusColor: AppColors.yellow,
                          antal: antalAvs),
                      BallWidget(
                          voteBallSize: voteBallSize,
                          statusColor: AppColors.blue,
                          antal: antalFr)
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
