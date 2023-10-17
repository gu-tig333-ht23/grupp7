import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../theme.dart';

class VoteResult extends StatelessWidget {
  VoteResult({super.key});

  Map<String, double> dataMap = {
    "Ja": 5,
    "Nej": 3,
    "Avstår": 2,
    "Frånvarande": 2,
  };

  List<Color> colorList = [
    AppColors.green,
    AppColors.red,
    AppColors.yellow,
    AppColors.mediumGrey
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        child: Column(
          children: [
            Text(
              'Resultat:',
              style: AppFonts.headerBlack,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 4,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 30,
                //centerText: "HYBRID",
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  decimalPlaces: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
