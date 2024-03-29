import 'package:flutter/material.dart';
import '../theme/theme.dart';

class Loadscreen extends StatelessWidget {
  const Loadscreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.lightGrey,
      ),
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
