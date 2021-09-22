import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/EighthScreen.dart';
import 'package:flutter_todo/screens/FifthScreen.dart';
import 'package:flutter_todo/screens/FourthScreen.dart';
import 'package:flutter_todo/screens/SecondScreen.dart';
import 'package:flutter_todo/screens/SeventhScreen.dart';
import 'package:flutter_todo/screens/SixthScreen.dart';
import 'package:flutter_todo/screens/ThirdScreen.dart';
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
    SecondScreen(),
    ThirdScreen(),
    FourthScreen(),
    FifthScreen(),
    SixthScreen(),
    SeventhScreen(),
    EighthScreen(),
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
                  left: 120,
                  top: 170,
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
