import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/model/menu.dart';
import 'package:flutter_todo/model/sub_menu.dart';
import 'package:flutter_todo/model/todo.dart';

class APIManager {
  final todoCollection = FirebaseFirestore.instance.collection('todo');
  final menuCollection = FirebaseFirestore.instance.collection('Menus');
  final subMenuCollection = FirebaseFirestore.instance.collection('SubMenus');
  List<Todo> myTask = [];

  /// This method will handle the stream of tasks added from fireStore
  Stream<List<Todo>> getDataStream() async* {
    Stream<QuerySnapshot> stream = todoCollection.snapshots();
    await for (QuerySnapshot snapshot in stream) {
      myTask.clear();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        var fooValue = Todo(
            id: doc.id,
            title: data['title'],
            completed: data['completed'],
            dateTime: data['dateTime'],
            priority: data['priority']); // <-- Retrieving the value.
        myTask.add(fooValue);
      }
      yield myTask;
    }
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
    try {
      await todoCollection.doc(id).update({'completed': true});
    } on FirebaseException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future<void> updateTaskPriority(String id, String priority) async {
    try {
      await todoCollection.doc(id).update({'priority': priority}).onError(
          (error, stackTrace) => print(error.toString()));
    } on FirebaseException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future<void> removeTask(String id) async {
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

  Stream<List<Menu>> fetchMenuStream() async* {
    Stream<QuerySnapshot> stream = menuCollection.snapshots();
    await for (QuerySnapshot snapshot in stream) {
      List<Menu> menuList = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        var menu = Menu(
            title: data['title'],
            childCount: data['childCount'],
            id: doc.id); // <-- Retrieving the value.
        menuList.add(menu);
      }
      yield menuList;
    }
  }

  Stream<List<SubMenu>> fetchSubMenuStream(String menuId) async* {
    Stream<QuerySnapshot> stream = subMenuCollection.snapshots();
    await for (QuerySnapshot snapshot in stream) {
      List<SubMenu> subMenuList = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        if (menuId == data['parentId']) {
          var menu = SubMenu(
              title: data['title'],
              childCount: data['childCount'],
              parentId: data['parentId'],
              id: doc.id); // <-- Retrieving the value.
          subMenuList.add(menu);
        }
      }
      yield subMenuList;
    }
  }

  void updateTaskCount(
      String taskCount, String menuId, String subMenuId) async {
    try {
      await subMenuCollection.doc(subMenuId).update({'childCount': taskCount});
    } on FirebaseException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }
}
