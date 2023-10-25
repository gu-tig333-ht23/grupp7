import 'package:flutter/material.dart';
import 'package:template/api/api_calendar/api_calendar.dart';
import 'package:template/screens/calendar_view.dart';
import '.././models/model_claendarevents.dart';

class ProviderCalendarView extends ChangeNotifier {
  List<CalendarEvents> _calendarEvents = [];
  List<CalendarEvents> get calendarEvents => _calendarEvents;

  ProviderCalendarView() {
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      List<CalendarEvents> fetchedEvents = await getEvents();
      _calendarEvents = fetchedEvents;
      notifyListeners();
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
