import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/landing_screen.dart';
import 'package:flutter_todo/util/CommonUtil.dart';
import 'package:flutter_todo/util/Constants.dart';
import 'package:flutter_todo/widget/button_widget.dart';

class SignUpOrSkipScreen extends StatelessWidget {
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
                    onAction: (val) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LandingScreen.id, (Route<dynamic> route) => false);
                    },
                  ),
                  ButtonWidget(
                    buttonTitle: 'Join',
                    controller: controller,
                    onAction: (val) {
                      bool validEmail = CommonUtil().isEmail(controller.text);
                      if (!validEmail) {
                        CommonUtil()
                            .showSnackBar(context, 'email is incorrect');
                        return;
                      }
                      controller.clear();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LandingScreen.id, (Route<dynamic> route) => false);
                    },
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
