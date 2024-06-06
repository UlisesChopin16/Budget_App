import 'package:budget_app/Components/sans_style_component.dart';
import 'package:flutter/material.dart';

class SnackBarComponent {
  static void successfullMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: NormalSans(
          text: message,
          color: Colors.white,
        ),
      ),
    );
  }

  static void errorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: NormalSans(
          text: 'Error adding expense',
          color: Colors.white,
        ),
      ),
    );
  }
}
