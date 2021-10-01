import 'package:flutter/material.dart';
import 'package:flutter_todo/bloc/reminder_bloc.dart';
import 'package:flutter_todo/model/block_event.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/util/CommonUtil.dart';
import 'package:flutter_todo/util/Constants.dart';
import 'package:flutter_todo/widget/custom_error_widget.dart';
import 'package:flutter_todo/widget/date_picker_widget.dart';
import 'package:flutter_todo/widget/dismissible_widget.dart';
import 'package:flutter_todo/widget/progress_indicator_widget.dart';

class ReminderScreen extends StatefulWidget {
  static String id = 'reminder_screen';
  final menuId;
  final subMenuId;

  ReminderScreen(this.menuId, this.subMenuId);

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  var reminderBloc = ReminderBloc();
  final List<Todo> myTask = [];
  final controller = TextEditingController();
  bool showDateTimeField = false;

  @override
  void initState() {
    super.initState();
    reminderBloc.eventSink.add(BlockEvent(eventId: UserAction.Fetch));
  }

  @override
  void dispose() {
    reminderBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            createReminderContainer(),
            dateTimerPickerView(context),
            Expanded(
              child: StreamBuilder(
                stream: reminderBloc.newsStream,
                builder: (context, snapshot) {
                  Widget widget;
                  if (!snapshot.hasData) {
                    widget = ProgressIndicatorWidget();
                  }
                  if (snapshot == null && snapshot.hasError) {
                    widget = CustomErrorWidget();
                  }
                  if (snapshot.hasData) {
                    myTask.clear();
                    myTask.addAll(snapshot.data);
                    updateTaskCount(myTask.length.toString());
                    widget = ReorderableListView(
                      children: getListItems(),
                      onReorder: reminderBloc.onReorder,
                    );
                  }
                  return widget;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getListItems() => myTask
      .asMap()
      .map((i, item) => MapEntry(i, buildTenableListTile1(item, i)))
      .values
      .toList();

  Widget buildTenableListTile1(Todo item, int index) {
    return DismissibleWidget(
      key: UniqueKey(),
      item: item,
      index: index,
      onActionChanged: (value) {
        setState(() {
          if (value == 'delete') {
            reminderBloc.eventSink
                .add(BlockEvent(eventId: UserAction.Delete, id: item.id));
          } else if (value == 'updateStatus') {
            reminderBloc.eventSink
                .add(BlockEvent(eventId: UserAction.UpdateStatus, id: item.id));
          }
        });
      },
    );
  }

  // Handle visibility of datePicker label to show datePicker view
  Visibility dateTimerPickerView(BuildContext context) {
    return Visibility(
      visible: showDateTimeField,
      child: Container(
        child: DatePickerView(
          onDateTimeChanged: (val) {
            setState(() {
              showDateTimeField = false;
            });
            addTask(val);
            controller.clear();
          },
        ),
      ),
    );
  }

  // Container to display the Input field to add to do task
  Container createReminderContainer() {
    return Container(
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.done,
        style: kReminderTextStyle,
        onSubmitted: (value) {
          if (controller.text.length > 0) {
            setState(() {
              showDateTimeField = true;
              CommonUtil().showSnackBar(context, "Choose date and time.");
            });
          }
        },
        cursorHeight: kTextFieldHeight,
        cursorWidth: kTextFieldWidth,
        decoration: kTextInputDecoration,
      ),
    );
  }

  void addTask(String dateTime) {
    reminderBloc.eventSink.add(BlockEvent(
        eventId: UserAction.Add,
        title: controller.text,
        dateTime: dateTime,
        completed: false,
        priority: 'Low',
        menuId: widget.menuId,
        subMenuId: widget.subMenuId));
  }

  void updateTaskCount(String length) {
    reminderBloc.eventSink.add(BlockEvent(
      eventId: UserAction.UpdateCount,
      menuId: widget.menuId,
      subMenuId: widget.subMenuId,
      taskCount: length,
    ));
  }
}
