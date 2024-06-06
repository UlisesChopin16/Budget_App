import 'package:budget_app/Components/asset_image_component.dart';
import 'package:budget_app/Components/material_button_component.dart';
import 'package:budget_app/Components/sans_style_component.dart';
import 'package:budget_app/login_view_model.dart';
import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({
    super.key,
    required this.loginViewModelProvider,
  });

  final LoginViewModel loginViewModelProvider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
    );
  }
}
