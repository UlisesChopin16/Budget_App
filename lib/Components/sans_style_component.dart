import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SansStyleComponent extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const SansStyleComponent({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.openSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

class NormalSans extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const NormalSans({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SansStyleComponent(
      text: text,
      fontSize: fontSize,
      color: color,
    );
  }
}

class BoldSans extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const BoldSans({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SansStyleComponent(
      text: text,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }
}
