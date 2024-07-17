import 'package:flutter/material.dart';
import 'package:quiz_app/view/screens/auth_screen/login.dart';
import 'package:quiz_app/view/screens/auth_screen/signup.dart';
import 'package:quiz_app/view/screens/choose_your_plan/choose_your_plan.dart';
import 'package:quiz_app/view/screens/free_test/free_test.dart';
import 'package:quiz_app/view/screens/home_screen/home_screen.dart';
import 'package:quiz_app/view/screens/missed_questions/missed_questions.dart';
import 'package:quiz_app/view/screens/payment_screen/payment_screen.dart';
import 'package:quiz_app/view/screens/random_questions/random_questions.dart';
import 'package:quiz_app/view/screens/review_screen/review_screen.dart';
import 'package:quiz_app/view/screens/saved_questions/save_question.dart';
import 'package:quiz_app/view/screens/setting_screen/setting_screen.dart';
import 'package:quiz_app/view/screens/stats_screen/stats_screen.dart';
import 'package:quiz_app/view/screens/subscription_screen/subscription_screen.dart';
import 'package:quiz_app/view/screens/ten_questions/ten_questions.dart';
import 'package:quiz_app/view/screens/timed_quiz/timed_quiz.dart';
import 'package:quiz_app/view/screens/todays_question/todays_questions.dart';
import 'package:quiz_app/widgets/bottom_bar.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  List<Widget> screens = [
    const HomePage(),
    const StatsScreen(),
    const ReviewScreen(),
  ];

  void onBtnClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: BottomBar(
        onTap: onBtnClick,
        screens: screens,
        selectedIndex: _selectedIndex,
      ),
      // initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        SettingScreen.routeName: (context) => const SettingScreen(),
        SubscriptionScreen.routeName: (context) => const SubscriptionScreen(),
        FreeTest.routeName: (context) => const FreeTest(),
        ChooseYourPlan.routeName: (context) => const ChooseYourPlan(),
        PaymentScreen.routeName: (context) => const PaymentScreen(),
        TenQuestions.routeName: (context) => const TenQuestions(),
        RandomQuestions.routeName: (context) => const RandomQuestions(),
        SaveQuestion.routeName: (context) => const SaveQuestion(),
        TimedQuiz.routeName: (context) => const TimedQuiz(),
        MissedQuestions.routeName: (context) => const MissedQuestions(),
        TodaysQuestions.routeName: (context) => TodaysQuestions(),
      },
    );
  }
}
