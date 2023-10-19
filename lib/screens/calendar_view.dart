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
        centerTitle: true,
        backgroundColor: AppColors.lightGrey,
        title: Text('Kalender', style: AppFonts.header),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
            child: FloatingActionButton(
              shape: CircleBorder(),
              tooltip: 'Om appen',
              backgroundColor: AppColors.lightGrey,
              onPressed: () async {
                aboutAppAlert(context);
              },
              child: const Icon(Icons.info),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).copyWith().size.height,
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset('assets/images/kollkollen_logo.png',
                  width: 75, height: 75),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: calendarEvents.length,
                itemBuilder: (context, index) {
                  return CalendarEvents(
                    title: calendarEvents[index].title,
                    description: calendarEvents[index].description,
                    decisionDate: calendarEvents[index].decisionDate,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
