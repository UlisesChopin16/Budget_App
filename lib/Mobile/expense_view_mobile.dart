import 'package:budget_app/Components/app_bar_component.dart';
import 'package:budget_app/Components/button_add_expense.dart';
import 'package:budget_app/Components/button_add_income.dart';
import 'package:budget_app/Components/drawer_component.dart';
import 'package:budget_app/Components/total_calculation_box.dart';
import 'package:budget_app/Mobile/Components/container_data_list_m.dart';
import 'package:budget_app/expense_view_model.dart';
import 'package:budget_app/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

bool isLoading = true;

class ExpenseViewMobile extends HookConsumerWidget {
  const ExpenseViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseviewModelProvider = ref.watch(expenseViewModel);
    final loginViewModelProvider = ref.watch(loginViewModel);

    if (isLoading) {
      expenseviewModelProvider.expensesStream();
      expenseviewModelProvider.incomesStream();
      isLoading = false;
    }

    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarComponent(expenseviewModelProvider: expenseviewModelProvider),
        drawer: DrawerComponent(loginViewModelProvider: loginViewModelProvider),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                TotalCalculationBox(
                  height: 240,
                  width: width / 1.5,
                  expenseviewModelProvider: expenseviewModelProvider,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonAddExpense(expenseviewModelProvider: expenseviewModelProvider),
                const SizedBox(
                  width: 10,
                ),
                ButtonAddIncome(expenseviewModelProvider: expenseviewModelProvider),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Expense list
                  ContainerDataListM(
                    listModel: expenseviewModelProvider.expenses,
                    nameContainer: 'Expenses',
                  ),
                  // Income list
                  ContainerDataListM(
                    listModel: expenseviewModelProvider.incomes,
                    nameContainer: 'Incomes',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
