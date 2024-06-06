import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldComponent extends StatelessWidget {
  final bool isObscure;

  final double? width;

  final List<TextInputFormatter>? inputFormatters;

  final String hintText;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;

  final TextAlign textAlign;

  final TextInputType? keyboardType;
  final TextEditingController? controller;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const TextFormFieldComponent({
    super.key,
    this.isObscure = false,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.hintStyle,
    this.width,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        textAlign: textAlign,
        obscureText: isObscure,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: hintStyle ?? GoogleFonts.openSans(),
        ),
      ),
    );
  }
}
