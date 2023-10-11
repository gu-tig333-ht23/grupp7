import 'package:flutter/material.dart';
import 'package:template/theme.dart';
import 'infocard_widget.dart';
import 'voteresult_piechart_widget.dart';
import 'partyvotes_widget.dart';

class InfoView extends StatelessWidget {
  InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'InfoView',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [InfoCard(), VoteResult(), PartyVotes()],
        ),
      ),
    );
  }
}
