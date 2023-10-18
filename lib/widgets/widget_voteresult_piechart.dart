import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:template/provider/provider_infoview.dart';
import '../theme.dart';

class VoteResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
  ProviderInfoView provider = Provider.of<ProviderInfoView>(context);

  Map<String, double> dataMap = {
      "Ja": provider.partiVotering.fold(0, (sum, vote) => sum + int.parse(vote.yes)),
      "Nej": provider.partiVotering.fold(0, (sum, vote) => sum + int.parse(vote.no)),
      "Avstår": provider.partiVotering.fold(0, (sum, vote) => sum + int.parse(vote.pass)),
      "Frånvarande": provider.partiVotering.fold(0, (sum, vote) => sum + int.parse(vote.abscent)),
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
