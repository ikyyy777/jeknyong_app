import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleConstant {
  static TextStyle get textStyleReguler => GoogleFonts.openSans();
  static TextStyle get textStyleSemiBold => GoogleFonts.openSans(fontWeight: FontWeight.w600);
  static TextStyle get textStyleBold => GoogleFonts.openSans(fontWeight: FontWeight.bold);
}
