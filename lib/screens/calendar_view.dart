import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/provider/provider_calendar.dart';
import 'package:template/theme.dart';
import 'package:template/widgets/widget_vote_card.dart';
import '../widgets/widget_about_app.dart';

class CalendarEvents extends StatelessWidget {
  final String title;
  final String description;
  final String decisionDate;

  CalendarEvents({
    super.key,
    required this.title,
    required this.description,
    required this.decisionDate,
  });

  @override
  Widget build(BuildContext context) {
    return voteCard(context, title, decisionDate, description);
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    var calendarEvents = context.watch<ProviderCalendarView>().calendarEvents;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Kalender', style: AppFonts.headerBlack),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
            child: IconButton(
              tooltip: 'Om appen',
              onPressed: () async {
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
              itemCount: calendarEvents.length,
              itemBuilder: (context, index) {
                return CalendarEvents(
                  title: calendarEvents[index].title,
                  description: calendarEvents[index].description,
                  decisionDate: calendarEvents[index].decisionDate,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
