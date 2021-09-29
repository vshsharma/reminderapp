import 'package:flutter/material.dart';
import 'package:flutter_todo/util/CommonUtil.dart';
import 'package:flutter_todo/util/Constants.dart';

import 'SubMenuList.dart';

class MenuList extends StatelessWidget {
  static String id = 'menu_list_screen';
  final List<String> menuList = [
    'My List',
    'Themes',
    'Tips & Tricks',
    'Follow the Team',
    'NewsLetter'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: ListView.builder(
            itemCount: menuList.length,
            itemBuilder: (context, int index) {
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  color: Color(0xFF616875),
                  margin: EdgeInsets.only(bottom: 1.0),
                  child: GestureDetector(
                    onTap: () {
                      if (menuList[index] == 'My List') {
                        CommonUtil().launchScreen(context, SubMenuList.id);
                      } else {
                        CommonUtil().showSnackBar(context, 'Not available');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                              child: Text(
                            menuList[index],
                            style: kStyleNormal.copyWith(
                              color: Colors.white,
                            ),
                          )),
                          flex: 8,
                        ),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
