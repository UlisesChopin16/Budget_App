import 'package:budget_app/Components/label_form_field_component.dart';
import 'package:budget_app/Components/material_button_component.dart';
import 'package:budget_app/Components/poppins_style_component.dart';
import 'package:budget_app/Components/sans_style_component.dart';
import 'package:budget_app/Components/snack_bar_component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final expenseViewModel =
    ChangeNotifierProvider.autoDispose<ExpenseViewModel>((ref) => ExpenseViewModel());

class ExpenseViewModel extends ChangeNotifier {

  final _auth = FirebaseAuth.instance;

  List expensesName = [];
  List expensesAmount = [];
  List incomesName = [];
  List incomesAmount = [];

  int totalExpense = 0;
  int totalIncome = 0;
  int budgetLeft = 0;

  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  late CollectionReference expensesCollection =
      userCollection.doc(_auth.currentUser!.uid).collection('expenses');
  late CollectionReference incomesCollection =
      userCollection.doc(_auth.currentUser!.uid).collection('incomes');

  

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

    add() async {
      if (formKey.currentState!.validate()) {
        await expensesCollection.add({
          'name': controllerName.text,
          'amount': controllerAmount.text,
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
            onPressed: add,
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

    add() async {
      if (formKey.currentState!.validate()) {
        await incomesCollection.add({
          'name': controllerName.text,
          'amount': controllerAmount.text,
        }).then(
          (value) {
            SnackBarComponent.successfullMessage(
              context,
              'Income added',
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
            onPressed: add,
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

    for (int i = 0; i < expensesAmount.length; i++) {
      totalExpense = totalExpense + int.parse(expensesAmount[i]);
    }
    for (int i = 0; i < incomesAmount.length; i++) {
      totalIncome = totalIncome + int.parse(incomesAmount[i]);
    }

    budgetLeft = totalIncome - totalExpense;
    notifyListeners();
  }

  void expensesStream() async {
    await for (var snapshot in expensesCollection.snapshots()) {
      expensesName = [];
      expensesAmount = [];
      for (var expense in snapshot.docs) {
        expensesName.add(expense['name']);
        expensesAmount.add(expense['amount']);
        notifyListeners();
      }
      calculate();
    }
  }

  void incomesStream() async {
    await for (var snapshot in incomesCollection.snapshots()) {
      incomesName = [];
      incomesAmount = [];
      for (var income in snapshot.docs) {
        incomesName.add(income['name']);
        incomesAmount.add(income['amount']);
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
