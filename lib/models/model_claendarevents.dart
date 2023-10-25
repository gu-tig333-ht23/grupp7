import 'package:flutter/material.dart';
import 'package:template/widgets/widget_vote_card.dart';

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
