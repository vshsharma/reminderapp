import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/model/Todo.dart';
import 'package:flutter_todo/util/Constants.dart';

class ReminderScreen extends StatefulWidget {
  static String id = 'ReminderScreen';

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final fireStore = FirebaseFirestore.instance;
  final List<Todo> myTask = [];
  final controller = TextEditingController();
  bool showDateTimeField = false;
  bool showReminderView = true;
  String dateTime;

  @override
  void initState() {
    super.initState();
    getTasksStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Visibility(
              visible: showReminderView,
              child: createReminderContainer(),
            ),
            dateTimerPickerView(context),
            Expanded(
              child: ReorderableListView(
                children: getListItems(),
                onReorder: onReorder,
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
            myTask.removeAt(index);
            fireStore.collection('todo').doc(item.id).delete();
          } else {
            if (item.completed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Task is already completed"),
              ));
            } else {
              fireStore
                  .collection('todo')
                  .doc(item.id)
                  .update({'completed': true});
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
        color: item.completed ? Colors.black87 : getBackGroundColor(index),
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
        child: dateTimePickerBuilder(context),
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
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: 'Enter reminder here',
          hintStyle: kReminderTextStyle,
          fillColor: Colors.red.shade800,
          filled: true,
        ),
      ),
    );
  }

  /// Display the dateTimePicker view
  DateTimePicker dateTimePickerBuilder(BuildContext context) {
    return DateTimePicker(
        type: DateTimePickerType.dateTime,
        decoration: InputDecoration(
          hintText: 'Select date and time',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: kDateTimeStyle,
          fillColor: Colors.red.shade800,
          filled: true,
        ),
        initialValue: '',
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: 'Date',
        onChanged: (val) async {
          setState(() {
            dateTime = val;
            showDateTimeField = false;
          });
          myTask.add(Todo(
              id: '',
              title: controller.text,
              completed: false,
              dateTime: dateTime));
          fireStore.collection('todo').add({
            'title': controller.text,
            'dateTime': dateTime,
            'completed': false
          });
          controller.clear();
          //showReminderView = false;
        },
        validator: (val) {
          return null;
        },
        onSaved: (val) {
          dateTime = val;
        });
  }

  /// Get different shades of colour for different tasks
  Color getBackGroundColor(int index) {
    return colorShades[Random().nextInt(5)];
  }

  // Handle reordering of task in list
  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex == myTask.length) {
        newIndex = myTask.length - 1;
      }
      var item = myTask.removeAt(oldIndex);
      if (newIndex == myTask.length) {
        fireStore.collection('todo').doc(item.id).update({'completed': true});
      }
      myTask.insert(newIndex, item);
    });
  }

  /// This method will handle the stream of tasks added from fireStore
  void getTasksStream() async {
    await for (var snapshot in fireStore.collection('todo').snapshots()) {
      myTask.clear();
      for (var message in snapshot.docs) {
        if (message != null &&
            message.get('title') != null &&
            message.get('dateTime') != null) {
          setState(() {
            myTask.add(Todo(
                id: message.id,
                title: message.get('title'),
                dateTime: message.get('dateTime'),
                completed: message.get('completed')));
          });
          setState(() {
            myTask.sort((a, b) {
              if (b.completed) {
                return -1;
              }
              return 1;
            });
          });
        }
      }
    }
  }
}
