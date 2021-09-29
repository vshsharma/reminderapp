import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/IcloudLoginOrSkipScreen.dart';
import 'package:flutter_todo/screens/PinchTogetherIntroductionScreen.dart';
import 'package:flutter_todo/screens/PriorityIntroductionScreen.dart';
import 'package:flutter_todo/screens/SignUpOrSkipScreen.dart';
import 'package:flutter_todo/screens/TapAndHoldIntroductionScreen.dart';
import 'package:flutter_todo/screens/TapOnListIntroductionScreen.dart';
import 'package:flutter_todo/screens/ThreeNavigationIntroductionScreen.dart';
import 'package:flutter_todo/widget/PageIndicator.dart';

class PageViewer extends StatefulWidget {
  static String id = 'PageViewer';

  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> offset;

  bool showPageIndicator = true;
  PageController controller = PageController();
  List<Widget> pageViewChild = [
    PriorityIntroductionScreen(),
    TapAndHoldIntroductionScreen(),
    ThreeNavigationIntroductionScreen(),
    PinchTogetherIntroductionScreen(),
    TapOnListIntroductionScreen(),
    IcloudLoginOrSkipScreen(),
    SignUpOrSkipScreen(),
  ];

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    offset = Tween<Offset>(
      begin: const Offset(0, 5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) =>
        MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            reverse: false,
            physics: BouncingScrollPhysics(),
            children: pageViewChild,
            controller: controller,
            onPageChanged: (num) {
              setState(() {
                showPageIndicator = num < 5 ? true : false;
                print(' current view is $num');
              });
            },
          ),
          Visibility(
            visible: showPageIndicator,
            child: Stack(
              children: [
                Positioned(
                  child: SlideTransition(
                    position: offset,
                    child: PageIndicator(controller, pageViewChild.length),
                  ),
                  left: deviceWidth(context) * 0.30,
                  top: deviceHeight(context) * 0.35,
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
