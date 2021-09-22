import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/PageViewer.dart';
import 'package:flutter_todo/screens/FirstScreen.dart';
import 'package:flutter_todo/screens/ReminderScreen.dart';
import 'package:flutter_todo/screens/SecondScreen.dart';

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
      initialRoute: FirstScreen.id,
      routes: {
        FirstScreen.id: (context) => FirstScreen(),
        SecondScreen.id: (context) => SecondScreen(),
        PageViewer.id: (context) => PageViewer(),
        ReminderScreen.id: (context) => ReminderScreen(),
      },
    );
  }
}
