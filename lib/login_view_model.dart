import 'package:budget_app/Components/snack_bar_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final loginViewModel =
    ChangeNotifierProvider.autoDispose((ref) => LoginViewModel());

class LoginViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  bool isLogged = false;
  bool isObscure = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> isLoggedIn() async {
    _auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          isLogged = false;
        } else {
          isLogged = true;
        }
        notifyListeners();
      },
    );
  }

  void toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> register(
      BuildContext context, String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        emailController.clear();
        passwordController.clear();
        SnackBarComponent.successfullMessage(
          context,
          'User created successfully',
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
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        emailController.clear();
        passwordController.clear();
        SnackBarComponent.successfullMessage(
          context,
          'User logged in successfully',
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
  }

  // method to login with google in web
  Future<void> loginWithGoogleWeb(BuildContext context) async {
    final googleProvider = GoogleAuthProvider();
    await _auth.signInWithPopup(googleProvider).then(
      (value) {
        SnackBarComponent.successfullMessage(
          context,
          'User logged in successfully',
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
  }

  // method to login with google in mobile
  Future<void> loginWithGoogleMobile(BuildContext context) async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn().then(
          (value) {
            SnackBarComponent.successfullMessage(
              context,
              'User logged in successfully',
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
    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential).then(
      (value) {
        SnackBarComponent.successfullMessage(
          context,
          'User logged in successfully',
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
  }

  Future<void> logout(BuildContext context) async {
    await _auth.signOut().then(
      (value) {
        emailController.clear();
        passwordController.clear();
        SnackBarComponent.successfullMessage(
          context,
          'User logged out successfully',
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
  }
}
