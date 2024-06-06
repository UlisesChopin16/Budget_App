import 'package:budget_app/Components/poppins_style_component.dart';
import 'package:budget_app/expense_view_model.dart';
import 'package:flutter/material.dart';

class TotalCalculationBox extends StatelessWidget {
  final double width;
  final double height;

  final double fontSize;

  final ExpenseViewModel expenseviewModelProvider;
  const TotalCalculationBox({
    super.key,
    required this.width,
    required this.height,
    this.fontSize = 14,
    required this.expenseviewModelProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 240,
      // width: width / 1.5,
      width: width,
      height: height,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalPoppins(
                text: 'Budget Left',
                fontSize: fontSize,
                color: Colors.white,
              ),
              NormalPoppins(
                text: 'Total Expense',
                fontSize: fontSize,
                color: Colors.white,
              ),
              NormalPoppins(
                text: 'Total Income',
                fontSize: fontSize,
                color: Colors.white,
              ),
            ],
          ),
          const RotatedBox(
            quarterTurns: 1,
            child: Divider(
              indent: 40,
              endIndent: 40,
              color: Colors.grey,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalPoppins(
                text: '\$ ${expenseviewModelProvider.budgetLeft}',
                fontSize: fontSize,
                color: Colors.white,
              ),
              NormalPoppins(
                text: '\$ ${expenseviewModelProvider.totalExpense}',
                fontSize: fontSize,
                color: Colors.white,
              ),
              NormalPoppins(
                text: '\$ ${expenseviewModelProvider.totalIncome}',
                fontSize: fontSize,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
