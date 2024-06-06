import 'package:budget_app/Components/poppins_style_component.dart';
import 'package:budget_app/Components/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelFormFieldComponent extends StatelessWidget {
  final bool isObscure;

  final double? width;

  final List<TextInputFormatter>? inputFormatters;

  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final TextEditingController? controller;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const LabelFormFieldComponent({
    super.key,
    required this.labelText,
    required this.hintText,
    this.isObscure = false,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        NormalPoppins(
          text: labelText,
          fontSize: 13,
        ),
        const SizedBox(height: 5),
        TextFormFieldComponent(
          width: width,
          textAlign: TextAlign.left,
          isObscure: isObscure,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 13,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}
