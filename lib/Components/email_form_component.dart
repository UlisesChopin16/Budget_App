import 'package:budget_app/Components/text_form_field_component.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmailFormComponent extends HookConsumerWidget {
  const EmailFormComponent({
    super.key,
  });

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);

    return TextFormFieldComponent(
      controller: viewModelProvider.emailController,
      hintText: 'Email',
      validator: validator,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(
        Icons.email,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}