import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/login_model.dart';
import 'package:quiz_app/widgets/bottom_bar.dart';

class LoginController {
  final _formKey = GlobalKey<FormState>();
  var emailAddress = "";
  var password = "";

  GlobalKey<FormState> get formKey => _formKey;

  void login(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      try {
        final userQuery = await FirebaseFirestore.instance
            .collection("Authentication")
            .where("email", isEqualTo: emailAddress)
            .get();

        if (userQuery.docs.isNotEmpty) {
          final userDoc = userQuery.docs.first;
          LoginModel user = LoginModel.fromFirestore(userDoc);

          if (user.password == password) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomBar()),
            );
          } else {
            _showErrorDialog(context, "Incorrect password");
          }
        } else {
          _showErrorDialog(context, "No account found with this email");
        }
      } catch (e) {
        _showErrorDialog(context, "Login Failed: ${e.toString()}");
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
