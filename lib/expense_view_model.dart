import 'package:budget_app/Components/label_form_field_component.dart';
import 'package:budget_app/Components/material_button_component.dart';
import 'package:budget_app/Components/poppins_style_component.dart';
import 'package:budget_app/Components/sans_style_component.dart';
import 'package:budget_app/Components/snack_bar_component.dart';
import 'package:budget_app/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final expenseViewModel =
    ChangeNotifierProvider.autoDispose<ExpenseViewModel>((ref) => ExpenseViewModel());

class ExpenseViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  List<ExpenseModel> expenses = [];
  List<ExpenseModel> incomes = [];

  int totalExpense = 0;
  int totalIncome = 0;
  int budgetLeft = 0;

  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  late CollectionReference expensesCollection =
      userCollection.doc(_auth.currentUser!.uid).collection('expenses');
  late CollectionReference incomesCollection =
      userCollection.doc(_auth.currentUser!.uid).collection('incomes');

  add(GlobalKey<FormState> formKey, String name, int amount, CollectionReference collection,
      BuildContext context) async {
    if (formKey.currentState!.validate()) {
      await collection.add({
        'name': name,
        'amount': amount,
      }).then(
        (value) {
          SnackBarComponent.successfullMessage(
            context,
            'Expense added',
          );
        },
      ).onError(
        (error, stackTrace) {
          SnackBarComponent.errorMessage(
            context,
            error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
          );
        },
      );
      if (!context.mounted) return;
      Navigator.pop(context);
    }
  }

  Future addExpense(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final TextEditingController controllerName = TextEditingController();
    final TextEditingController controllerAmount = TextEditingController();

    String? validator(String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'This field is required';
      }
      return null;
    }

    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.all(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const NormalPoppins(
          text: 'Add Expense',
          fontSize: 20,
          color: Colors.black,
        ),
        content: Form(
          key: formKey,
          child: Row(
            children: [
              LabelFormFieldComponent(
                labelText: 'Name',
                controller: controllerName,
                width: 130,
                hintText: 'Name',
                validator: validator,
              ),
              const SizedBox(width: 16),
              LabelFormFieldComponent(
                labelText: 'Amount',
                controller: controllerAmount,
                width: 100,
                hintText: 'Amount',
                validator: validator,
              ),
            ],
          ),
        ),
        actions: [
          MaterialButtonComponent(
            onPressed: () async {
              await add(
                formKey,
                controllerName.text,
                int.parse(controllerAmount.text),
                expensesCollection,
                context,
              );
            },
            child: const NormalSans(
              text: 'Save',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Future addIncome(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final TextEditingController controllerName = TextEditingController();
    final TextEditingController controllerAmount = TextEditingController();

    String? validator(String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'This field is required';
      }
      return null;
    }

    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.all(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const NormalPoppins(
          text: 'Add Income',
          fontSize: 20,
          color: Colors.black,
        ),
        content: Form(
          key: formKey,
          child: Row(
            children: [
              LabelFormFieldComponent(
                labelText: 'Name',
                controller: controllerName,
                width: 130,
                hintText: 'Name',
                validator: validator,
              ),
              const SizedBox(width: 16),
              LabelFormFieldComponent(
                labelText: 'Amount',
                controller: controllerAmount,
                width: 100,
                hintText: 'Amount',
                validator: validator,
              ),
            ],
          ),
        ),
        actions: [
          MaterialButtonComponent(
            onPressed: () async {
              await add(
                formKey,
                controllerName.text,
                int.parse(controllerAmount.text),
                incomesCollection,
                context,
              );
            },
            child: const NormalSans(
              text: 'Save',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  void calculate() {
    totalExpense = 0;
    totalIncome = 0;

    for (int i = 0; i < expenses.length; i++) {
      totalExpense = totalExpense + expenses[i].amount;
    }
    for (int i = 0; i < incomes.length; i++) {
      totalIncome = totalIncome + incomes[i].amount;
    }

    budgetLeft = totalIncome - totalExpense;
    notifyListeners();
  }

  void expensesStream() async {
    await for (var snapshot in expensesCollection.orderBy('amount', descending: true).snapshots()) {
      expenses.clear();
      for (var expense in snapshot.docs) {
        expenses.add(ExpenseModel.fromJson(expense.data() as Map<String, dynamic>));
        notifyListeners();
      }
      calculate();
    }
  }

  void incomesStream() async {
    await for (var snapshot in incomesCollection.orderBy('amount', descending: true).snapshots()) {
      incomes.clear();
      for (var income in snapshot.docs) {
        incomes.add(ExpenseModel.fromJson(income.data() as Map<String, dynamic>));
        notifyListeners();
      }
      calculate();
    }
  }

  Future<void> reset() async {
    await expensesCollection.get().then(
      (snapshot) {
        for (var expense in snapshot.docs) {
          expense.reference.delete();
        }
      },
    );

    await incomesCollection.get().then(
      (snapshot) {
        for (var income in snapshot.docs) {
          income.reference.delete();
        }
      },
    );
  }
}
