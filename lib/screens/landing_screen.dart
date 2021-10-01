import 'package:flutter/material.dart';
import 'package:flutter_todo/bloc/menu_bloc.dart';
import 'package:flutter_todo/model/menu.dart';
import 'package:flutter_todo/util/CommonUtil.dart';
import 'package:flutter_todo/util/Constants.dart';
import 'package:flutter_todo/widget/custom_error_widget.dart';
import 'package:flutter_todo/widget/progress_indicator_widget.dart';

import 'task_category_list.dart';

class LandingScreen extends StatefulWidget {
  static String id = 'menu_list_screen';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var menuBloc = MenuBloc();

  @override
  void initState() {
    menuBloc.eventSink.add(MenuAction.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: StreamBuilder(
          stream: menuBloc.menuStream,
          builder: (context, snapshot) {
            if (snapshot != null && !snapshot.hasData) {
              return ProgressIndicatorWidget();
            }
            if (snapshot.hasError) {
              return CustomErrorWidget();
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  Menu menu = snapshot.data[index];
                  return Container(
                      height: 50.0,
                      color: Color(0xFF616875),
                      margin: EdgeInsets.only(bottom: 1.0),
                      child: GestureDetector(
                        onTap: () {
                          if (menu.title == 'My Lists') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TodoCategoryListScreen(menu.id)));
                          } else {
                            CommonUtil().showSnackBar(context, 'Not available');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                    menu.title,
                                    style: kStyleNormal.copyWith(
                                      color: Colors.white,
                                    ),
                                  )),
                              flex: 9,
                            ),
                            Container(
                              color: Color(0xFF787F8C),
                              height: double.maxFinite,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(
                                menu.childCount,
                                style:
                                    kStyleNormal.copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ));
                });
          },
        ),
      ),
    );
  }
}
