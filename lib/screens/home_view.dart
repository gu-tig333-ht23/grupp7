import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/screens/calendar_view.dart';
import '../widgets/widget_about_app.dart';
import '../theme/theme.dart';
import '../provider/provider_home_view.dart';
import '.././models/model_dokument.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var voteringar = context.watch<ProviderHomeView>().voteringar;

    if (!context.read<ProviderHomeView>().aboutAppAlertShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        aboutAppAlert(context);
        context.read<ProviderHomeView>().aboutAppAlertShown = true;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CalendarView(),
              ),
            );
          },
          icon: Icon(Icons.calendar_month, color: AppColors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Beslutade voteringar', style: AppFonts.headerBlack),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
            child: IconButton(
              tooltip: 'Om appen',
              onPressed: () {
                aboutAppAlert(context);
              },
              icon: Icon(Icons.info, color: AppColors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset('assets/images/kollkollen_logo.png',
                  width: 75, height: 75),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: voteringar.length,
              itemBuilder: (context, index) {
                return Dokument(
                  identificationYear: voteringar[index].identificationYear,
                  beteckning: voteringar[index].beteckning,
                  title: voteringar[index].title,
                  decisionDate: voteringar[index].decisionDate,
                  organ: voteringar[index].organ,
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
