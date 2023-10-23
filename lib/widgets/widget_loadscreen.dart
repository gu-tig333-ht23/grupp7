import 'package:flutter/material.dart';
import '../theme.dart';

class Loadscreen extends StatelessWidget {
  const Loadscreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.backgroundColor,
          child: Center(
            child: CircularProgressIndicator(color: AppColors.blue),
          ),
        ),
      ),
    );
  }
}
