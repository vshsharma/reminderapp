import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/ReminderScreen.dart';
import 'package:flutter_todo/util/Constants.dart';

class EighthScreen extends StatelessWidget {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign up to the newsletter, and unlock a theme for your lists.',
              textAlign: TextAlign.center,
              style: kStyleNormal,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              height: 150,
              child: Image.asset('images/email.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kButtonSidePadding, right: kButtonSidePadding),
              child: Column(
                children: [
                  TextField(
                    autofocus: false,
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: OutlineInputBorder(),
                      hintText: 'Email address',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kButtonSidePadding, right: kButtonSidePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWidget(
                    buttonTitle: 'Skip',
                    controller: controller,
                  ),
                  ButtonWidget(
                    buttonTitle: 'Join',
                    controller: controller,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class ButtonWidget extends StatelessWidget {
  ButtonWidget({this.buttonTitle, this.controller});

  final String buttonTitle;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            side: BorderSide(color: Colors.black, width: 1),
            padding: EdgeInsets.only(
                left: kButtonSidePadding, right: kButtonSidePadding)),
        child: Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: kScreenTitleFont, fontWeight: FontWeight.normal),
        ),
        onPressed: () {
          if (buttonTitle == 'Join') {
            bool validEmail = isEmail(controller.text);
            if (!validEmail) {
              return;
            }
            controller.clear();
          }
          Navigator.of(context).pushNamedAndRemoveUntil(
              ReminderScreen.id, (Route<dynamic> route) => false);
        });
  }

  bool isEmail(String string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
}
