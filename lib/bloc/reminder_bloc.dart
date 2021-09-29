import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/bloc/BaseBloc.dart';
import 'package:flutter_todo/model/BlockEvent.dart';
import 'package:flutter_todo/model/Todo.dart';
import 'package:flutter_todo/service/ApiManager.dart';

enum UserAction { Fetch, Add, Delete, UpdatePriority, UpdateStatus }

class ReminderBloc extends BaseBloc {
  final todoCollection = FirebaseFirestore.instance.collection('todo');
  List<Todo> myTask = [];

  final _eventController = StreamController<BlockEvent>();
  StreamSink<BlockEvent> get eventSink => _eventController.sink;
  Stream<BlockEvent> get _eventStream => _eventController.stream;

  final _streamController = StreamController<List<Todo>>.broadcast();
  StreamSink<List<Todo>> get _newsSink => _streamController.sink;
  Stream<List<Todo>> get newsStream => _streamController.stream;

  ReminderBloc() {
    _eventStream.listen((event) async {
      if (event.eventId == UserAction.Fetch) {
        Stream myStream = APIManager().getDataStream();
        myStream.listen((snapshot) {
          myTask.clear();
          for (Todo todo in snapshot) {
            myTask.add(todo);
          }
          sortListWithCompletedTaskAtBottom();
        });
      } else if (event.eventId == UserAction.Add) {
        APIManager().addTask(
            message: event.title,
            dateTime: event.dateTime,
            completed: event.completed,
            priority: event.priority);
      } else if (event.eventId == UserAction.UpdatePriority) {
        APIManager().updateTaskPriority(event.id, event.priority);
      } else if (event.eventId == UserAction.UpdateStatus) {
        APIManager().updateTask(event.id);
      } else if (event.eventId == UserAction.Delete) {
        APIManager().removeTask(event.id);
      }
    });
  }

  @override
  void dispose() {
    _streamController.close();
    _eventController.close();
  }

  void sortListWithCompletedTaskAtBottom() {
    List<Todo> highPriority = [];
    List<Todo> mediumPriority = [];
    List<Todo> lowPriority = [];

    for (Todo todo in myTask) {
      if (todo.priority == 'High') {
        highPriority.add(todo);
      } else if (todo.priority == 'Medium') {
        mediumPriority.add(todo);
      } else if (todo.priority == 'Low') {
        lowPriority.add(todo);
      }
    }

    myTask.clear();
    myTask.addAll(lowPriority);
    myTask.addAll(mediumPriority);
    myTask.addAll(highPriority);

    myTask.sort((a, b) {
      if (b.completed) {
        return -1;
      }
      return 1;
    });
    _newsSink.add(myTask);
  }

  // Handle reordering of task in list
  void onReorder(int oldIndex, int newIndex) {
    if (newIndex == myTask.length) {
      newIndex = myTask.length - 1;
    }
    var item = myTask.removeAt(oldIndex);
    if (newIndex == myTask.length) {
      eventSink.add(BlockEvent(eventId: UserAction.UpdateStatus, id: item.id));
    } else if (newIndex == 0) {
      eventSink.add(BlockEvent(
          eventId: UserAction.UpdatePriority, id: item.id, priority: 'High'));
    } else if (newIndex < oldIndex) {
      eventSink.add(BlockEvent(
          eventId: UserAction.UpdatePriority, id: item.id, priority: 'Medium'));
    } else if (newIndex > oldIndex) {
      eventSink.add(BlockEvent(
          eventId: UserAction.UpdatePriority, id: item.id, priority: 'Low'));
    }
    // myTask.insert(newIndex, item);
    // sortListWithCompletedTaskAtBottom();
  }
}
