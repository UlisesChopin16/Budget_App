import 'package:budget_app/Components/sans_style_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final viewModel = ChangeNotifierProvider.autoDispose((ref) => ViewModel());

class ViewModel extends ChangeNotifier {
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

  Future<void> register(BuildContext context, String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        emailController.clear();
        passwordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: NormalSans(text: 'User created successfully', fontSize: 16),
          ),
        );
      },
    ).onError(
      (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: NormalSans(
                text: error.toString().replaceAll(RegExp('\\[.*?\\]'), ''), fontSize: 16),
          ),
        );
      },
    );
  }

  Future<void> login(BuildContext context, String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        emailController.clear();
        passwordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: NormalSans(
              text: 'User logged in successfully',
              fontSize: 16,
            ),
          ),
        );
      },
    ).onError(
      (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: NormalSans(
              text: error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }

  // method to login with google in web
  Future<void> loginWithGoogleWeb(BuildContext context) async {
    final googleProvider = GoogleAuthProvider();
    await _auth.signInWithPopup(googleProvider).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: NormalSans(
              text: 'User logged in successfully',
              fontSize: 16,
            ),
          ),
        );
      },
    ).onError(
      (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: NormalSans(
              text: error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }

  // method to login with google in mobile
  Future<void> loginWithGoogleMobile(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().onError(
      (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: NormalSans(
              text: error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
              fontSize: 16,
            ),
          ),
        );
        return null;
      },
    );
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _auth.signInWithCredential(credential).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: NormalSans(
              text: 'User logged in successfully',
              fontSize: 16,
            ),
          ),
        );
      },
    ).onError(
      (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: NormalSans(
              text: error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    await _auth.signOut().then(
      (value) {
        emailController.clear();
        passwordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: NormalSans(
              text: 'User logged out successfully',
              fontSize: 16,
            ),
          ),
        );
      },
    ).onError(
      (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: NormalSans(
              text: error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
