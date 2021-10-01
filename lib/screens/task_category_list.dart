import 'package:flutter/material.dart';
import 'package:flutter_todo/bloc/reminder_bloc.dart';
import 'package:flutter_todo/bloc/sub_menu_bloc.dart';
import 'package:flutter_todo/model/block_event.dart';
import 'package:flutter_todo/model/request_sub_menu.dart';
import 'package:flutter_todo/model/sub_menu.dart';
import 'package:flutter_todo/screens/reminder_screen.dart';
import 'package:flutter_todo/util/CommonUtil.dart';
import 'package:flutter_todo/util/Constants.dart';
import 'package:flutter_todo/widget/custom_error_widget.dart';
import 'package:flutter_todo/widget/progress_indicator_widget.dart';

class TodoCategoryListScreen extends StatefulWidget {
  static String id = 'sub_menu_list_screen';
  final menuId;

  TodoCategoryListScreen(this.menuId);

  @override
  _TodoCategoryListScreenState createState() => _TodoCategoryListScreenState();
}

class _TodoCategoryListScreenState extends State<TodoCategoryListScreen> {
  final reminderBloc = ReminderBloc();
  final subMenuBloc = SubMenuBloc();

  @override
  void initState() {
    reminderBloc.eventSink.add(BlockEvent(eventId: UserAction.Fetch));
    subMenuBloc.eventSink
        .add(RequestSubMenu(event: SubMenuAction.Fetch, menuId: widget.menuId));
    super.initState();
  }

  @override
  void dispose() {
    reminderBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: StreamBuilder(
          stream: subMenuBloc.menuStream,
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
                  SubMenu subMenu = snapshot.data[index];
                  return Container(
                      height: 50.0,
                      color: Color(0xFF4E83EB),
                      margin: EdgeInsets.only(bottom: 1.0),
                      child: GestureDetector(
                        onTap: () {
                          if (subMenu.title == 'Personnel List') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReminderScreen(
                                        subMenu.parentId, subMenu.id)));
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
                                    subMenu.title,
                                    style: kStyleNormal.copyWith(
                                      color: Colors.white,
                                    ),
                                  )),
                              flex: 9,
                            ),
                            Container(
                              color: Color(0xFF6295ED),
                              height: double.maxFinite,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(subMenu.childCount,
                                  style: kStyleNormal.copyWith(
                                      color: Colors.white)),
                            ),
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
