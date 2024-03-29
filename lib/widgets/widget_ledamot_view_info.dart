import 'package:flutter/material.dart';
import '../models/model_ledarmot_info.dart';

class LedamotViewInfo extends StatelessWidget {
  final LedamotInfo ledamot;

  LedamotViewInfo({
    Key? key,
    required this.ledamot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = ledamot.imageUrl;
    String ledamotNamn = ledamot.ledamotNamn;
    String ledamotStatus = ledamot.ledamotStatus;

    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: ClipOval(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.9,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
        ),
        Text(ledamotNamn),
        Text(ledamotStatus),
      ],
    );
  }
}
