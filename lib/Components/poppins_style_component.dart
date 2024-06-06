import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppinsStyleComponent extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const PoppinsStyleComponent({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = Colors.black,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}

class NormalPoppins extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign? textAlign;

  const NormalPoppins({super.key, required this.text, this.fontSize = 16, this.color = Colors.black, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return PoppinsStyleComponent(
      text: text,
      fontSize: fontSize,
      color: color,
      textAlign: textAlign,
    );
  }
}

class BoldPoppins extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign? textAlign;

  const BoldPoppins({super.key, required this.text, this.fontSize = 16, this.color = Colors.black, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return PoppinsStyleComponent(
      text: text,
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.bold,
      textAlign: textAlign,
    );
  }
}
