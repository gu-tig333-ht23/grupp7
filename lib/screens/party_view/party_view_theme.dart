import '../../theme/theme.dart';
import 'package:flutter/material.dart';

class PartyAppBarTheme {
  final String id;
  final String name;
  final String assetImage;
  final Color color;
  final String webPage;

  PartyAppBarTheme(
      this.id, this.name, this.assetImage, this.color, this.webPage);
}

List<PartyAppBarTheme> partyList = [
  PartyAppBarTheme("S", "Socialdemokraterna", AppImages.imageSocialdemokraterna,
      AppColors.socialdemokraternaRed, "https://www.socialdemokraterna.se"),
  PartyAppBarTheme(
      "SD",
      "Sverigedemokraterna",
      "assets/images/sverigedemokraterna.png",
      AppColors.sverigedemokraternaBlue,
      "https://www.sverigedemokraterna.se"),
  PartyAppBarTheme("M", "Moderaterna", AppImages.imageModeraterna,
      AppColors.moderaternaBlue, "https://www.moderaterna.se"),
  PartyAppBarTheme("KD", "Kristdemokraterna", AppImages.imageKristdemokraterna,
      AppColors.kristdemokraternaBlue, "https://www.kristdemokraterna.se"),
  PartyAppBarTheme("L", "Liberalerna", AppImages.imageLiberalerna,
      AppColors.liberalernaBlue, "https://www.liberalerna.se"),
  PartyAppBarTheme("C", "Centerpartiet", AppImages.imageCenterpartietWhite,
      AppColors.centerpartietGreen, "https://www.centerpartiet.se"),
  PartyAppBarTheme("MP", "Miljöpartiet de gröna", AppImages.imageMiljopartiet,
      AppColors.miljopartietGreen, "https://www.mp.se"),
  PartyAppBarTheme("V", "Vänsterpartiet", AppImages.imageVansterpartiet,
      AppColors.vansterpartietRed, "https://www.vansterpartiet.se"),
];
