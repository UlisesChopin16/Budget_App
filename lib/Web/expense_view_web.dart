import 'package:budget_app/Components/app_bar_component.dart';
import 'package:budget_app/Components/asset_image_component.dart';
import 'package:budget_app/Components/button_add_expense.dart';
import 'package:budget_app/Components/button_add_income.dart';
import 'package:budget_app/Components/drawer_component.dart';
import 'package:budget_app/Components/total_calculation_box.dart';
import 'package:budget_app/Web/Components/container_data_list.dart';
import 'package:budget_app/expense_view_model.dart';
import 'package:budget_app/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

bool isLoading = true;

class ExpenseViewWeb extends HookConsumerWidget {
  const ExpenseViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final loginviewModelProvider = ref.watch(loginViewModel);
    final expenseviewModelProvider = ref.watch(expenseViewModel);
    if (isLoading) {
      expenseviewModelProvider.expensesStream();
      expenseviewModelProvider.incomesStream();
      isLoading = false;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerComponent(
          loginViewModelProvider: loginviewModelProvider,
        ),
        appBar: AppBarComponent(
          expenseviewModelProvider: expenseviewModelProvider,
        ),
        body: SizedBox(
          height: height > 600 ? height : 600,
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AssetImageComponent(
                      assetPath: 'assets/images/login_image.png',
                      width: width / 3.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ButtonAddExpense(
                              expenseviewModelProvider: expenseviewModelProvider,
                              fontSize: 17,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ButtonAddIncome(
                              expenseviewModelProvider: expenseviewModelProvider,
                              fontSize: 17,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        TotalCalculationBox(
                          height: 300,
                          width: 300,
                          fontSize: 17,
                          expenseviewModelProvider: expenseviewModelProvider,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Divider(
                indent: width / 4,
                endIndent: width / 4,
                thickness: 3,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ContainerDataList(
                    nameContainer: 'Expenses',
                    listModel: expenseviewModelProvider.expenses,
                  ),
                  ContainerDataList(
                    nameContainer: 'Incomes',
                    listModel: expenseviewModelProvider.incomes,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
