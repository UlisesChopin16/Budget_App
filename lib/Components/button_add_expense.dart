import 'package:budget_app/Components/material_button_component.dart';
import 'package:budget_app/Components/sans_style_component.dart';
import 'package:budget_app/expense_view_model.dart';
import 'package:flutter/material.dart';

class ButtonAddExpense extends StatelessWidget {
  final double fontSize;
  const ButtonAddExpense({
    super.key,
    required this.expenseviewModelProvider,
    this.fontSize = 14,
  });

  final ExpenseViewModel expenseviewModelProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 155,
      child: MaterialButtonComponent(
        onPressed: () {
          // expenseviewModelProvider.navigateToExpense(context);
          expenseviewModelProvider.addExpense(context);
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
              text: 'Add Expense',
              fontSize: fontSize,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
