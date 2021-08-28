import 'package:flutter/material.dart';

class Palette {
  static const Color background = Color(0xFF111A26);
  static const Color finnaDarkBox = Color(0xFF141E2C);
  static const Color finnaGreen = Color(0xFF47E887);
  static const Color finnaGold = Color(0xFFEDC801);
  static const Color finnaBox = Color(0xFFFFFFFF);
  static const Color finnaBlackText = Color(0xFF3D4857);
  static const Color finnaGreenText = Color(0xFF32CA6E);
  static const Color finnaRedText = Color(0xFFDB2D2D);
  static const Color finnaDropShadow = Color(0xFF141221);
  static const Color finnaBoxShadow = Color(0xFF020811);
  static const Color transparent = Color(0x00000000);
  static const Color finnaWhiteText = Color(0xBFFFFFFF);
}

class GetUri {
  String getUri = "http://33b835ff7f26.ngrok.io/finance-chart/";
}

LinearGradient getGreenGradient() {
  final List<Color> color = <Color>[];
  color.add(Palette.finnaGreen.withOpacity(0.3));
  color.add(Palette.finnaDarkBox);

  final List<double> stops = <double>[];
  stops.add(0.0);
  stops.add(1.0);

  final LinearGradient gradientColors = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: color,
      stops: stops);
  return gradientColors;
}

LinearGradient getRedGradient() {
  final List<Color> color = <Color>[];
  color.add(Palette.finnaRedText.withOpacity(0.3));
  color.add(Palette.finnaDarkBox);

  final List<double> stops = <double>[];
  stops.add(0.0);
  stops.add(1.0);

  final LinearGradient gradientColors = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: color,
      stops: stops);
  return gradientColors;
}

BoxDecoration baseBackgroundDecoration = BoxDecoration(
  color: Palette.finnaDarkBox,
  borderRadius: BorderRadius.circular(14.0),
  boxShadow: [
    BoxShadow(
      color: Palette.finnaDropShadow.withOpacity(0.50),
      blurRadius: 4,
      offset: Offset(0, 4), // changes position of shadow
    ),
  ],
);

InputDecoration baseInputFieldDecoration(
        {String label, String hint, Icon icon}) =>
    InputDecoration(
      border: UnderlineInputBorder(),
      labelText: label,
      labelStyle: TextStyle(color: Palette.finnaWhiteText),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Palette.finnaDarkBox,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Palette.finnaDarkBox,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Palette.finnaGreenText,
        ),
      ),
      suffixIcon: icon != null ? icon : null,
    );
