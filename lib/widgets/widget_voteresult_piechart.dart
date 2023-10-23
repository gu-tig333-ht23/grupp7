import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:template/provider/provider_infoview.dart';
import '../theme.dart';

class VoteResult extends StatelessWidget {
  final double ja;
  final double nej;
  final double avstar;
  final double franvarande;
  final String titel;

  VoteResult({
    required this.ja,
    required this.nej,
    required this.avstar,
    required this.franvarande,
    required this.titel,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Ja": ja,
      "Nej": nej,
      "Avstår": avstar,
      "Frånvarande": franvarande,
    };

    List<Color> colorList = [
      AppColors.green,
      AppColors.red,
      AppColors.yellow,
      AppColors.blue
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        child: Column(
          children: [
            Text(
              titel,
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
                  showChartValuesOutside: true,
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
