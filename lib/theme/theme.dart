import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  static final primaryBlue = HexColor('005293');
  static final secondaryBlue = HexColor('1a3050');
  static final secondaryYellow = HexColor('ffd481');
  static final backgroundColor = HexColor('ffffff');
  static final darkGrey = HexColor('424242');
  static final mediumGrey = HexColor('757575');
  static final lightGrey = HexColor('bdbdbd');
  static final black = HexColor('000000');
  static final red = HexColor('d1382b');
  static final green = HexColor('01a87c');
  static final yellow = HexColor('fecb00');
  static final purple = HexColor('522e91');
  static final blue = HexColor('0099d3');

  static final socialdemokraternaRed = HexColor('e7132c');
  static final moderaternaBlue = HexColor('213a8f');
  static final sverigedemokraternaBlue = HexColor('322667');
  static final vansterpartietRed = HexColor('ff0000');
  static final liberalernaBlue = HexColor('006ab3');
  static final centerpartietGreen = HexColor('114838');
  static final miljopartietGreen = HexColor('4c983e');
  static final kristdemokraternaBlue = HexColor('0b5ea1');
}

class AppFonts {
  static final pageHeader =
      GoogleFonts.roboto(fontSize: 28, color: HexColor('ffffff'));
  static final header =
      GoogleFonts.roboto(fontSize: 20, color: HexColor('ffffff'));
  static final headerBlack =
      GoogleFonts.roboto(fontSize: 20, color: HexColor('000000'));
  static final numberBlack =
      GoogleFonts.roboto(fontSize: 20, color: HexColor('000000'));
  static final headerRed =
      GoogleFonts.roboto(fontSize: 24, color: HexColor('d1382b'));
  static final headerGreen =
      GoogleFonts.roboto(fontSize: 24, color: HexColor('01a87c'));
  static final title =
      GoogleFonts.roboto(fontSize: 16, color: HexColor('ffffff'));
  static final normalTextWhite =
      GoogleFonts.roboto(fontSize: 14, color: HexColor('ffffff'));
  static final normalTextBlack =
      GoogleFonts.roboto(fontSize: 14, color: HexColor('000000'));
  static final smallText = GoogleFonts.roboto(
      fontSize: 12, fontStyle: FontStyle.italic, color: HexColor('ffffff'));
}

class AppImages {
  static const imageSverigedemokraterna =
      'assets/images/sverigedemokraterna.png';

  static const imageSocialdemokraterna = 'assets/images/socialdemokraterna.png';

  static const imageCenterpartietWhite =
      'assets/images/centerpartiet_white.png';

  static const imageModeraterna = 'assets/images/moderaterna.png';

  static const imageLiberalerna = 'assets/images/liberalerna.webp';

  static const imageVansterpartiet = 'assets/images/vansterpartiet.png';

  static const imageKristdemokraterna = 'assets/images/kristdemokraterna.png';

  static const imageMiljopartiet = 'assets/images/miljopartiet.png';
}
