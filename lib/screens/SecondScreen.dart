import 'package:flutter/material.dart';
import 'package:flutter_todo/util/Constants.dart';

class SecondScreen extends StatefulWidget {
  static var id = 'SecondScreen';

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    offset = Tween<Offset>(
      begin: const Offset(0, 10),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    animationController.forward();
  }

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
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Clear sorts item by ',
                        style: kStyleNormal,
                        children: <TextSpan>[
                          TextSpan(text: 'Priority', style: kStyleBold),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Important items are highlighted at the top....',
                    textAlign: TextAlign.center,
                    style: kStyleNormal,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SlideTransition(
              position: offset,
              child: Container(
                child: Image.asset('images/img.png'),
                padding: EdgeInsets.only(
                    top: kSidePadding, left: kSidePadding, right: kSidePadding),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
