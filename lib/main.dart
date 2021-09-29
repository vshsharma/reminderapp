import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/PageViewer.dart';
import 'package:flutter_todo/screens/IntroductionScreen.dart';
import 'package:flutter_todo/screens/MenuList.dart';
import 'package:flutter_todo/screens/ReminderScreen.dart';
import 'package:flutter_todo/screens/SubMenuList.dart';

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
        MenuList.id: (context) => MenuList(),
        SubMenuList.id: (context) => SubMenuList(),
        PageViewer.id: (context) => PageViewer(),
        ReminderScreen.id: (context) => ReminderScreen(),
      },
    );
  }
}
