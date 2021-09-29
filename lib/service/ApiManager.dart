import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/model/Todo.dart';

class APIManager {
  final todoCollection = FirebaseFirestore.instance.collection('todo');
  List<Todo> myTask = [];

  /// This method will handle the stream of tasks added from fireStore
  Stream<List<Todo>> getDataStream() async* {
    todoCollection.snapshots().listen((querySnapshot) async* {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        var fooValue = Todo(
            id: data['id'],
            title: data['title'],
            completed: data['completed'],
            dateTime: data['dateTime'],
            priority: data['priority']); // <-- Retrieving the value.
        myTask.add(fooValue);
      }
      yield myTask;
    });
    //yield myTask;
  }

  Future<bool> addTask(
      {String message,
      String dateTime,
      bool completed,
      String priority}) async {
    bool status;
    await todoCollection
        .add({
          'title': message,
          'dateTime': dateTime,
          'completed': completed,
          'priority': priority
        })
        .then((value) => status = true)
        .catchError((error) => status = false);
    return status;
  }

  Future<void> updateTask(String id) async {
    print(id);
    await todoCollection.doc(id).update({'completed': true});
  }

  Future<void> updateTaskPriority(String id, String priority) async {
    print(id);
    await todoCollection.doc(id).update({'priority': priority});
  }

  Future<void> removeTask(String id) async {
    print(id);
    await todoCollection.doc(id).delete();
  }
}
