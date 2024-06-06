import 'package:budget_app/Components/asset_image_component.dart';
import 'package:budget_app/Components/material_button_component.dart';
import 'package:budget_app/Components/poppins_style_component.dart';
import 'package:budget_app/Components/sans_style_component.dart';
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
    double width = MediaQuery.of(context).size.width;

    int totalExpense = 0;
    int totalIncome = 0;

    void calculate() {
      for (int i = 0; i < expenseviewModelProvider.expensesAmount.length; i++) {
        totalExpense = totalExpense + int.parse(expenseviewModelProvider.expensesAmount[i]);
      }
      for (int i = 0; i < expenseviewModelProvider.incomesAmount.length; i++) {
        totalIncome = totalIncome + int.parse(expenseviewModelProvider.incomesAmount[i]);
      }
    }

    calculate();

    int budgetLeft = totalIncome - totalExpense;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const NormalPoppins(
            text: 'Dashboard',
            fontSize: 20,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                /// refresh the page
              },
              icon: const Icon(
                Icons.refresh,
              ),
            )
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              DrawerHeader(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 180,
                    backgroundColor: Colors.white,
                    child: AssetImageComponent(
                      assetPath: 'assets/images/logo.png',
                      width: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: MaterialButtonComponent(
                  padding: const EdgeInsets.all(10),
                  onPressed: () async {
                    await loginViewModelProvider.logout(context);
                  },
                  child: const NormalSans(
                    text: 'Logout',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 240,
                  width: width / 1.5,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalPoppins(
                            text: 'Budget Left',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          NormalPoppins(
                            text: 'Total Expense',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          NormalPoppins(
                            text: 'Total Income',
                            fontSize: 14,
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          NormalPoppins(
                            text: '\$ $budgetLeft',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          NormalPoppins(
                            text: '\$ $totalExpense',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          NormalPoppins(
                            text: '\$ $totalIncome',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 155,
                  child: MaterialButtonComponent(
                    onPressed: () {
                      // expenseviewModelProvider.navigateToExpense(context);
                      expenseviewModelProvider.addExpense(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                        NormalSans(
                          text: 'Add Expense',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 40,
                  width: 155,
                  child: MaterialButtonComponent(
                    onPressed: () {
                      // expenseviewModelProvider.navigateToIncome(context);
                      expenseviewModelProvider.addIncome(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                        NormalSans(
                          text: 'Add Income',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
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
                  Column(
                    children: <Widget>[
                      const NormalPoppins(
                        text: 'Expenses',
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        height: 200,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: expenseviewModelProvider.expensesAmount.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                NormalPoppins(
                                  text: expenseviewModelProvider.expensesName[index],
                                  fontSize: 12,
                                ),
                                NormalPoppins(
                                  text: expenseviewModelProvider.expensesAmount[index],
                                  fontSize: 12,
                                ),
                              ],
                            );
                          },
                        
                        ),
                      ),
                    ],
                  ),
                  // Income list
                  Column(
                    children: <Widget>[
                      const NormalPoppins(
                        text: 'Incomes',
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        height: 200,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: expenseviewModelProvider.incomesAmount.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                NormalPoppins(
                                  text: expenseviewModelProvider.incomesName[index],
                                  fontSize: 12,
                                ),
                                NormalPoppins(
                                  text: expenseviewModelProvider.incomesAmount[index],
                                  fontSize: 12,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
