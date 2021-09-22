import 'package:flutter/material.dart';
import 'package:flutter_todo/util/Constants.dart';

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top * 5;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(
        margin: EdgeInsets.only(
            top: topPadding, left: kSidePadding, right: kSidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: kSidePadding, right: kSidePadding),
              child: Column(
                children: [
                  Text(
                    'There are three navigation levels....',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              child: Image.asset('images/img.png'),
              padding: EdgeInsets.only(
                  top: kSidePadding, left: kSidePadding, right: kSidePadding),
            )
          ],
        ),
      ),
    ));
  }
}
