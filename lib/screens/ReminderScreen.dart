import 'package:flutter/material.dart';
import 'package:flutter_todo/bloc/reminder_bloc.dart';
import 'package:flutter_todo/model/BlockEvent.dart';
import 'package:flutter_todo/model/Todo.dart';
import 'package:flutter_todo/util/CommonUtil.dart';
import 'package:flutter_todo/util/Constants.dart';
import 'package:flutter_todo/widget/DatePickerView.dart';

class ReminderScreen extends StatefulWidget {
  static String id = 'reminder_screen';

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
                    widget = Center(
                      child: snapshot.hasData == null
                          ? CircularProgressIndicator()
                          : Text('No Data available'),
                    );
                  }
                  if (snapshot.hasError) {
                    widget = Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  if (snapshot.hasData) {
                    myTask.clear();
                    myTask.addAll(snapshot.data);
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
      .map((i, item) => MapEntry(i, buildTenableListTile(item, i)))
      .values
      .toList();

  Widget buildTenableListTile(Todo item, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        setState(() {
          if (direction == DismissDirection.endToStart) {
            reminderBloc.eventSink
                .add(BlockEvent(eventId: UserAction.Delete, id: item.id));
          } else {
            if (item.completed) {
              CommonUtil().showSnackBar(context, 'Task is already completed');
            } else {
              reminderBloc.eventSink.add(
                  BlockEvent(eventId: UserAction.UpdateStatus, id: item.id));
            }
          }
        });
      },
      background: Container(
        padding: EdgeInsets.all(kListItemPadding),
        alignment: Alignment.centerLeft,
        color: Colors.green,
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(kListItemPadding),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 0.5),
        color: item.completed
            ? Colors.black87
            : CommonUtil().getBackGroundColor(item.priority),
        child: ListTile(
          enabled: !item.completed,
          title: Text(item.title,
              style:
                  item.completed ? kTextCompletedStyle : kTextInCompletedStyle),
          subtitle: Text(
            item.dateTime,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Choose date and time."),
              ));
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
        priority: 'Low'));
  }
}
