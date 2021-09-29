import 'package:flutter/material.dart';
import 'package:flutter_todo/bloc/reminder_bloc.dart';
import 'package:flutter_todo/model/BlockEvent.dart';
import 'package:flutter_todo/model/Todo.dart';
import 'package:flutter_todo/screens/ReminderScreen.dart';
import 'package:flutter_todo/util/CommonUtil.dart';
import 'package:flutter_todo/util/Constants.dart';

class SubMenuList extends StatefulWidget {
  static String id = 'sub_menu_list_screen';

  @override
  _SubMenuListState createState() => _SubMenuListState();
}

class _SubMenuListState extends State<SubMenuList> {
  final reminderBloc = ReminderBloc();

  final List<String> subMenuList = [
    'Personnel List',
    'Shopping List',
    'Marketing list'
  ];

  @override
  void initState() {
    reminderBloc.eventSink.add(BlockEvent(eventId: UserAction.Fetch));
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
        child: ListView.builder(
            itemCount: subMenuList.length,
            itemBuilder: (context, int index) {
              return Container(
                color: Color(0xFF4E83EB),
                margin: EdgeInsets.only(bottom: 1.0),
                child: ListTile(
                  trailing: Container(
                    child: StreamBuilder(
                      stream: reminderBloc.newsStream,
                      builder: (context, snapshot) {
                        if (snapshot != null && snapshot.hasData) {
                          List<Todo> todoList = snapshot.data;
                          int size = todoList.length;
                          return Text(
                            "$size",
                            style: kStyleNormal.copyWith(color: Colors.white),
                          );
                        } else {
                          return Text('0');
                        }
                      },
                    ),
                  ),
                  title: Text(
                    subMenuList[index],
                    style: kStyleNormal.copyWith(color: Colors.white),
                  ),
                  onTap: () {
                    if (subMenuList[index] == 'Personnel List') {
                      CommonUtil().launchScreen(context, ReminderScreen.id);
                    } else {
                      CommonUtil().showSnackBar(context, 'Not available');
                    }
                  },
                ),
              );
            }),
      ),
    );
  }
}
