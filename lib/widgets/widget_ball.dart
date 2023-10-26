import 'package:flutter/material.dart';

class BallWidget extends StatelessWidget {
  final double voteBallSize;
  final Color statusColor;
  final String antal;

  BallWidget(
      {super.key, required this.voteBallSize,
      required this.statusColor,
      required this.antal});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white, // Color of the border
              width: 2.0, // Width of the border
            ),
            borderRadius: BorderRadius.circular(voteBallSize),
            color: Colors.white,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: statusColor, // Color of the border
                width: 2.0, // Width of the border
              ),
              borderRadius: BorderRadius.circular(voteBallSize),
              color: Colors.white,
            ),
            width: voteBallSize,
            height: voteBallSize,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  antal,
                  style: TextStyle(color: statusColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
