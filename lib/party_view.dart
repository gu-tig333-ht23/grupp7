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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("assets/images/socialdemokraterna.png"),
                  height: 100,
                  width: 100,
                ),
                Text(
                  "Socialdemokraterna",
                  style: AppFonts.headerRed,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // lägg till bild på partiledare här
                ClipOval(
                  child: Image.network(
                    'https://data.riksdagen.se/filarkiv/bilder/ledamot/dcc2ab7d-3fc1-4a28-b3c7-be1679c047b3_80.jpg',
                    width: 50, // Adjust the size as needed
                    height: 50, // Adjust the size as needed
                    fit: BoxFit.cover,
                  ),
                ),

                Column(
                  children: [
                    Text("Partiledare"),
                    Text("Magdalena Andersson"),
                    SizedBox(
                      height: 16,
                    ),
                    Text("www.socialdemokraterna.se")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
