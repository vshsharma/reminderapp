import 'package:flutter/material.dart';
import 'package:flutter_todo/util/Constants.dart';

class ButtonWidget extends StatelessWidget {
  final ValueChanged<String> onAction;

  ButtonWidget({this.buttonTitle, this.controller, this.onAction});

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
          onAction('pressed');
        });
  }
}
