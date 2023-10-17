import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/screens/home_view.dart';
import 'package:template/provider/provider_calendar.dart';
import 'package:template/theme.dart';

class CalendarEvents extends StatelessWidget {
  final String title;
  final String description;
  final String decisionDate;
  final int index;

  CalendarEvents({
    super.key,
    required this.title,
    required this.description,
    required this.decisionDate,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid, color: AppColors.yellow, width: 1.8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.4),
                ),
              ], 
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppFonts.title),
                      Text(description, style: AppFonts.normalTextWhite),
                      Text('Datum: $decisionDate', style: AppFonts.smallText)
                    ]
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      )
    );
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
              child: const Icon(Icons.info)
            ),
          ),
        ]
      ),
      body: Container(
        height: MediaQuery.of(context).copyWith().size.height,
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset('assets/images/kollkollen_logo.png', width: 75, height: 75),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: calendarEvents.length,
                itemBuilder: (context, index) {
                  return CalendarEvents(
                    title: calendarEvents[index].title,
                    description: calendarEvents[index].description,
                    decisionDate: calendarEvents[index].decisionDate,
                    index: index,
                  );
                },
              ),
            ),
          ],
        )
      )
    );
  }
}