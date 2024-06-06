import 'package:budget_app/Components/email_form_component.dart';
import 'package:budget_app/Components/material_button_component.dart';
import 'package:budget_app/Components/password_form_component.dart';
import 'package:budget_app/Components/sans_style_component.dart';
import 'package:budget_app/login_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginFormComponent extends HookConsumerWidget {
  const LoginFormComponent({super.key});

  static void onPressedRegister(BuildContext context, WidgetRef ref) async {
    final viewModelProvider = ref.read(loginViewModel);

    if (viewModelProvider.formKey.currentState!.validate()) {
      await viewModelProvider.register(context, viewModelProvider.emailController.text,
          viewModelProvider.passwordController.text);
      viewModelProvider.isLogged;
    }
  }

  static void onPressedLogin(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.read(loginViewModel);

    if (viewModelProvider.formKey.currentState!.validate()) {
      viewModelProvider.login(context, viewModelProvider.emailController.text,
          viewModelProvider.passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(loginViewModel);

    return SingleChildScrollView(
      child: Form(
        key: viewModelProvider.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              width: 300,
              child: EmailFormComponent(),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: 300,
              child: PasswordFormComponent(),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: MaterialButtonComponent(
                    onPressed: () => onPressedRegister(context, ref),
                    child: const NormalSans(
                      text: 'Register',
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Or',
                  style: GoogleFonts.pacifico(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: MaterialButtonComponent(
                      onPressed: () => onPressedLogin(context, ref),
                      child: const NormalSans(
                        text: 'Login',
                        fontSize: 25,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SignInButton(
              buttonType: ButtonType.google,
              btnColor: Colors.black,
              btnTextColor: Colors.white,
              buttonSize: ButtonSize.large,
              onPressed: () async {
                if (kIsWeb) {
                  await viewModelProvider.loginWithGoogleWeb(context);
                } else {
                  await viewModelProvider.loginWithGoogleMobile(context);
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
