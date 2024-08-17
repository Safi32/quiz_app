import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/free_test_provider.dart';
import 'package:quiz_app/services/topic_services.dart';
import 'package:quiz_app/view/screens/auth_screen/login.dart';
import 'package:quiz_app/view/screens/auth_screen/signup.dart';
import 'package:quiz_app/view/screens/choose_your_plan/choose_your_plan.dart';
import 'package:quiz_app/view/screens/fetch_topics/fetch_topics.dart';
import 'package:quiz_app/view/screens/free_test/free_test.dart';
import 'package:quiz_app/view/screens/home_screen/home_screen.dart';
import 'package:quiz_app/view/screens/missed_questions/missed_questions.dart';
import 'package:quiz_app/view/screens/payment_screen/payment_screen.dart';
import 'package:quiz_app/view/screens/random_questions/random_questions.dart';
import 'package:quiz_app/view/screens/saved_questions/save_question.dart';
import 'package:quiz_app/view/screens/setting_screen/setting_screen.dart';
import 'package:quiz_app/view/screens/subscription_screen/subscription_screen.dart';
import 'package:quiz_app/view/screens/ten_questions/ten_questions.dart';
import 'package:quiz_app/view/screens/timed_quiz/timed_quiz.dart';
import 'package:quiz_app/view/screens/todays_question/todays_questions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final topicService = TopicService();
  await topicService.initializeTopics();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FreeTestProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: LoginScreen(),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        SettingScreen.routeName: (context) => const SettingScreen(),
        SubscriptionScreen.routeName: (context) => const SubscriptionScreen(),
        FreeTest.routeName: (context) => FreeTest(),
        ChooseYourPlan.routeName: (context) => const ChooseYourPlan(),
        PaymentScreen.routeName: (context) => const PaymentScreen(),
        TenQuestions.routeName: (context) => TenQuestions(),
        RandomQuestions.routeName: (context) => RandomQuestions(),
        SaveQuestion.routeName: (context) => SaveQuestion(),
        TimedQuiz.routeName: (context) => const TimedQuiz(),
        MissedQuestions.routeName: (context) => MissedQuestions(),
        TodaysQuestions.routeName: (context) => TodaysQuestions(),
        FetchTopics.routeName: (context) => const FetchTopics(),
      },
    );
  }
}
