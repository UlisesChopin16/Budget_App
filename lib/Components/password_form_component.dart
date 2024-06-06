import 'package:budget_app/Components/text_form_field_component.dart';
import 'package:budget_app/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PasswordFormComponent extends HookConsumerWidget {
  const PasswordFormComponent({
    super.key,
  });

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(loginViewModel);

    return TextFormFieldComponent(
      controller: viewModelProvider.passwordController,
      isObscure: viewModelProvider.isObscure,
      hintText: 'Password',
      validator: validator,
      prefixIcon: const Icon(
        Icons.lock,
        color: Colors.black,
        size: 30,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          viewModelProvider.isObscure ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          viewModelProvider.toggleObscure();
        },
      ),
    );
  }
}
