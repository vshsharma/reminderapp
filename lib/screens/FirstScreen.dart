import 'package:flutter/material.dart';
import 'package:flutter_todo/PageViewer.dart';
import 'package:flutter_todo/util/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ReminderScreen.dart';

class FirstScreen extends StatelessWidget {
  static var id = 'FirstScreen';

  @override
  Widget build(BuildContext context) {
    statusNTUData(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            launchPageViewer(context);
          },
          onHorizontalDragUpdate: (detail) {
            launchPageViewer(context);
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                  text: 'Welcome to ',
                  style: kStyleNormal,
                  children: <TextSpan>[
                    TextSpan(text: 'Clear', style: kStyleBold),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                  text: 'Tap or Swipe ',
                  style: kStyleBold,
                  children: <TextSpan>[
                    TextSpan(text: 'to begin', style: kStyleNormal),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchPageViewer(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, PageViewer.id, (Route<dynamic> route) => false);
  }
}

///
void statusNTUData(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('ntu') != null && prefs.getBool('ntu')) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        ReminderScreen.id, (Route<dynamic> route) => false);
  } else {
    await prefs.setBool('ntu', true);
  }
}
