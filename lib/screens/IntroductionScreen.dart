import 'package:flutter/material.dart';
import 'package:flutter_todo/PageViewer.dart';
import 'package:flutter_todo/screens/MenuList.dart';
import 'package:flutter_todo/util/CommonUtil.dart';
import 'package:flutter_todo/util/Constants.dart';

class IntroductionScreen extends StatelessWidget {
  static var id = 'introduction_screen';

  @override
  Widget build(BuildContext context) {
    CommonUtil().statusNTUData(context, MenuList.id);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            CommonUtil().launchPageViewer(context, PageViewer.id);
          },
          onHorizontalDragUpdate: (detail) {
            CommonUtil().launchPageViewer(context, PageViewer.id);
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
}
