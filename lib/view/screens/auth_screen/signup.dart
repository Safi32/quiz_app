import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/view/screens/auth_screen/login.dart';
import 'package:quiz_app/widgets/textformfield.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "Signup";

  const SignUpScreen({Key? key});

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
                    backgroundImage: AssetImage(
                      "assets/account.png",
                    ),
                    radius: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Sign up to continue",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      TextformfieldWidget(
                        hintText: "Username",
                        onPress: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter valid username";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextformfieldWidget(
                        hintText: "Email address",
                        onPress: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains("@") ||
                              !value.contains(".com")) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextformfieldWidget(
                        hintText: "Password",
                        onPress: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () {},
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have account?",
                            ),
                            Text(
                              "login",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
