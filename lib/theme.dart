import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  final primaryBlue = HexColor('005293');
  final secondaryBlue = HexColor('1a3050');
  final secondaryYellow = HexColor('ffd481');
  final backgroundColor = HexColor('ffffff');
  final darkGrey = HexColor('424242');
  final mediumGrey = HexColor('757575');
  final lightGrey = HexColor('bdbdbd'); 
  final black = HexColor('000000');
  final red = HexColor('d1382b');
  final green = HexColor('01a87c');
  final yellow = HexColor('fecb00');
}

class AppFonts {
  static final pageHeader = GoogleFonts.roboto(fontSize: 28, color: HexColor('ffffff'));
  static final header = GoogleFonts.roboto(fontSize: 24, color: HexColor('ffffff'));
  static final title = GoogleFonts.roboto(fontSize: 16, color: HexColor('ffffff'));
  static final normalTextWhite = GoogleFonts.roboto(fontSize: 14, color: HexColor('ffffff'));
  static final normalTextBlack = GoogleFonts.roboto(fontSize: 14, color: HexColor('000000'));
  static final smallText = GoogleFonts.roboto(fontSize: 12, fontStyle: FontStyle.italic, color: HexColor('ffffff'));
}

