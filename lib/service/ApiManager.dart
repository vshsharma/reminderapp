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

  Future<void> addTask(
      {String message,
      String dateTime,
      bool completed,
      String priority}) async {
    try {
      await todoCollection.add({
        'title': message,
        'dateTime': dateTime,
        'completed': completed,
        'priority': priority
      });
    } on FirebaseException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future<void> updateTask(String id) async {
    print(id);
    try {
      await todoCollection.doc(id).update({'completed': true});
    } on FirebaseException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future<void> updateTaskPriority(String id, String priority) async {
    print(id);
    try {
      await todoCollection.doc(id).update({'priority': priority}).onError(
          (error, stackTrace) => print(error.toString()));
    } on FirebaseException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future<void> removeTask(String id) async {
    print(id);
    try {
      await todoCollection
          .doc(id)
          .delete()
          .onError((error, stackTrace) => print(error.toString()));
    } on FirebaseException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }
}
