import 'package:budget_app/Components/poppins_style_component.dart';
import 'package:budget_app/expense_view_model.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({
    super.key,
    required this.expenseviewModelProvider,
  });

  final ExpenseViewModel expenseviewModelProvider;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            await expenseviewModelProvider.reset();
          },
          icon: const Icon(
            Icons.refresh,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

