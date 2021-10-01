import 'package:flutter/material.dart';
import 'package:flutter_todo/util/Constants.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final buttonTitle;
  const OutlinedButtonWidget({Key key, this.buttonTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // todo
      },
      child: Text(
        buttonTitle,
        style: kStyleNormal,
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 1, color: Colors.black),
      ),
    );
  }
}
