import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/signup_model.dart';

final _firebase = FirebaseAuth.instance;

class SignupController {
  final _formKey = GlobalKey<FormState>();
  var enteredUsername = "";
  var enteredEmail = "";
  var enteredPassword = "";

  GlobalKey<FormState> get formKey => _formKey;

  void submit(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        final String userID = userCredential.user!.uid;

        final user = SignupModel(
          userID: userID,
          username: enteredUsername,
          email: enteredEmail,
          password: enteredPassword,
        );

        await FirebaseFirestore.instance
            .collection("Authentication")
            .doc(userID)
            .set(user.toMap())
            .then((_) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Signup Successful'),
              content: const Text('You have been signed up successfully.'),
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
        }).catchError((error) {
          print("Failed to add user: $error");
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Signup Failed'),
              content: Text('Failed to save data: $error'),
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
        });
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == "email-already-in-use") {
          errorMessage = "This email is already in use.";
        } else if (e.code == "weak-password") {
          errorMessage = "The password is too weak.";
        } else {
          errorMessage = e.message ?? "Signup failed. Please try again.";
        }

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Signup Failed'),
            content: Text(errorMessage),
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
  }
}
