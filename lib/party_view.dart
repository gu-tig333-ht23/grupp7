import 'package:flutter/material.dart';
import 'theme.dart';

class PartyView extends StatelessWidget {
  PartyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Partivy",
          style: AppFonts.title,
        ),
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Socialdemokraterna",
                  style: TextStyle(color: Colors.red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
