import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

String baseUrl = "https://newsapi.org/v2/everything?";
String token = "6975dc346ae44021bbdb995007a82ca1";

myStyle(double size, Color clr, [FontWeight? fw]) {
  return GoogleFonts.nunito(fontSize: size, color: clr, fontWeight: fw);
}
