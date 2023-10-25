import 'package:flutter/material.dart';

class PartyViewDivider extends StatelessWidget {
  const PartyViewDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, top: 8.0, bottom: 0),
      child: Divider(
        thickness: 1,
        color: Colors.black,
      ),
    );
  }
}
