import 'package:budget_app/Components/asset_image_component.dart';
import 'package:budget_app/Components/login_form_component.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginViewWeb extends HookConsumerWidget {
  const LoginViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: height > 600 ? height : 600,
          child: Center(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AssetImageComponent(
                    assetPath: 'assets/images/login_image.png',
                    width: width / 2.6,
                  ),
                  const LoginFormComponent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
