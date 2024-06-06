import 'package:budget_app/Components/material_button_component.dart';
import 'package:budget_app/Components/sans_style_component.dart';
import 'package:budget_app/expense_view_model.dart';
import 'package:flutter/material.dart';

class ButtonAddIncome extends StatelessWidget {
  final double fontSize;
  const ButtonAddIncome({
    super.key,
    this.fontSize = 14,
    required this.expenseviewModelProvider,
  });

  final ExpenseViewModel expenseviewModelProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 155,
      child: MaterialButtonComponent(
        onPressed: () {
          // expenseviewModelProvider.navigateToIncome(context);
          expenseviewModelProvider.addIncome(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
              size: 15,
            ),
            NormalSans(
              text: 'Add Income',
              fontSize: fontSize,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
