import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/page_viewer.dart';
import 'package:flutter_todo/screens/introduction_screen.dart';
import 'package:flutter_todo/screens/landing_screen.dart';
import 'package:flutter_todo/screens/reminder_screen.dart';
import 'package:flutter_todo/screens/task_category_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: IntroductionScreen.id,
      routes: {
        IntroductionScreen.id: (context) => IntroductionScreen(),
        LandingScreen.id: (context) => LandingScreen(),
        TodoCategoryListScreen.id: (context) => TodoCategoryListScreen(''),
        PageViewer.id: (context) => PageViewer(),
        ReminderScreen.id: (context) => ReminderScreen('', ''),
      },
    );
  }
}
