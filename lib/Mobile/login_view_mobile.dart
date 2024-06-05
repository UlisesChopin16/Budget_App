import 'package:budget_app/Components/login_form_component.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginViewMobile extends HookConsumerWidget {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final double height = MediaQuery.of(context).size.height;

    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: LoginFormComponent(),
        ),
      ),
    );
  }
}
