import 'package:flutter/material.dart';
import '../../class_votering.dart';
import '../../theme.dart';

class LedamotVyStatBar extends StatelessWidget {
  LedamotVyStatBar({
    super.key,
    required this.theList,
  }) {
    setStat();
  }

  List<voteringar> theList;
  double antalJa = 0;
  double antalNej = 0;
  double antalAvstar = 0;
  double antalFranvarande = 0;
  int antalTotal = 0;

  setStat() {
    antalTotal = theList.length;
    antalJa =
        antalTotal == 0 ? 0 : ((100 / antalTotal) * (ledarmotAntalJa('Ja')));
    antalNej =
        antalTotal == 0 ? 0 : ((100 / antalTotal) * (ledarmotAntalJa('Nej')));
    antalAvstar = antalTotal == 0
        ? 0
        : ((100 / antalTotal) * (ledarmotAntalJa('Avstår')));
    antalFranvarande = antalTotal == 0
        ? 0
        : ((100 / antalTotal) * (ledarmotAntalJa('Frånvarande')));
  }

  int ledarmotAntalJa(rostTyp) {
    List svarLista = theList;
    int antalSvar = 0;

    svarLista.forEach((element) {
      if (element.rost == rostTyp) {
        antalSvar += 1;
      }
    });
    print('$rostTyp $antalSvar');
    return antalSvar;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        children: [
          StatBar(
            antalJa: antalJa,
            antalNej: antalNej,
            antalAvstar: antalAvstar,
            antalFranvarande: antalFranvarande,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.radio_button_checked,
                  color: AppColors.green,
                ),
                Text('Ja  '),
                Icon(
                  Icons.radio_button_checked,
                  color: AppColors.red,
                ),
                Text('Nej '),
                Icon(
                  Icons.radio_button_checked,
                  color: AppColors.purple,
                ),
                Text('Avstår  '),
                Icon(
                  Icons.radio_button_checked,
                  color: AppColors.blue,
                ),
                Text('Frånvarande'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatBar extends StatelessWidget {
  StatBar({
    required this.antalJa,
    required this.antalNej,
    required this.antalAvstar,
    required this.antalFranvarande,
  });

  double antalJa;
  double antalNej;
  double antalAvstar;
  double antalFranvarande;
  double padding = 20;

  @override
  Widget build(BuildContext context) {
    final double screenWidth =
        ((MediaQuery.of(context).size.width) - padding * 2) / 100;
    return Container(
      padding: EdgeInsets.only(
          bottom: 5, top: padding, left: padding, right: padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Row(
          children: [
            Container(
                color: AppColors.green,
                child: SizedBox(
                  height: 50,
                  width: screenWidth * antalJa,
                )),
            Container(
                color: AppColors.red,
                child: SizedBox(
                  height: 50,
                  width: screenWidth * antalNej,
                )),
            Container(
                color: AppColors.purple,
                child: SizedBox(
                  height: 50,
                  width: screenWidth * antalAvstar,
                )),
            Container(
                color: AppColors.blue,
                child: SizedBox(
                  height: 50,
                  width: screenWidth * antalFranvarande,
                )),
          ],
        ),
      ),
    );
  }
}
