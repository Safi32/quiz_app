import 'package:flutter/material.dart';
import 'package:quiz_app/controllers/signup_controller.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/view/screens/auth_screen/login.dart';
import 'package:quiz_app/widgets/textformfield.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "Signup";
  final SignupController _controller = SignupController();

  SignUpScreen({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/account.png"),
                    radius: 100,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Sign up to continue",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _controller.formKey,
                    child: Column(
                      children: [
                        TextformfieldWidget(
                          hintText: "Username",
                          onPress: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid username";
                            }
                            _controller.enteredUsername = value; 
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextformfieldWidget(
                          hintText: "Email address",
                          onPress: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains("@") ||
                                !value.contains(".com")) {
                              return "Please enter a valid email address";
                            }
                            _controller.enteredEmail = value; 
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextformfieldWidget(
                          hintText: "Password",
                          onPress: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a password";
                            }
                            _controller.enteredPassword = value; 
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            onPressed: () {
                              _controller.submit(context); 
                            },
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              Text(
                                "Login",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
