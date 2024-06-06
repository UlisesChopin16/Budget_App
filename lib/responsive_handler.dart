import 'package:budget_app/Mobile/expense_view_mobile.dart';
import 'package:budget_app/Mobile/login_view_mobile.dart';
import 'package:budget_app/Web/expense_view_web.dart';
import 'package:budget_app/Web/login_view_web.dart';
import 'package:budget_app/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResponsiveHandler extends HookConsumerWidget {
  const ResponsiveHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return authState.when(
      data: (value) {
        if (value == null) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return const LoginViewWeb();
              } else {
                return const LoginViewMobile();
              }
            },
          );
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return const ExpenseViewWeb();
            } else {
              return const ExpenseViewMobile();
            }
          },
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return const LoginViewWeb();
            } else {
              return const LoginViewMobile();
            }
          },
        );
      },
    );
  }
}
