import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../models/model_ledarmot_info.dart';

class LedamortAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LedamortAppBar({
    super.key,
    required this.ledamot,
  });

  final LedamotInfo ledamot;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        ledamot.ledamotNamn,
      ),
      centerTitle: true,
      backgroundColor: (ledamot.ledamotParti == 'S')
          ? AppColors.socialdemokraternaRed
          : (ledamot.ledamotParti == 'M')
              ? AppColors.moderaternaBlue
              : (ledamot.ledamotParti == 'C')
                  ? AppColors.centerpartietGreen
                  : (ledamot.ledamotParti == 'L')
                      ? AppColors.liberalernaBlue
                      : (ledamot.ledamotParti == 'KD')
                          ? AppColors.kristdemokraternaBlue
                          : (ledamot.ledamotParti == 'V')
                              ? AppColors.vansterpartietRed
                              : (ledamot.ledamotParti == 'SD')
                                  ? AppColors.sverigedemokraternaBlue
                                  : (ledamot.ledamotParti == 'MP')
                                      ? AppColors.miljopartietGreen
                                      : AppColors.backgroundColor,
      elevation: 0,
    );
  }
}
