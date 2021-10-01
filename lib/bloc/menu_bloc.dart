import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/bloc/base_bloc.dart';
import 'package:flutter_todo/model/menu.dart';
import 'package:flutter_todo/service/api_manager.dart';

enum MenuAction { Fetch }

class MenuBloc extends BaseBloc {
  final menuCollection = FirebaseFirestore.instance.collection('Menus');

  final _eventController = StreamController<MenuAction>();
  StreamSink<MenuAction> get eventSink => _eventController.sink;
  Stream<MenuAction> get _eventStream => _eventController.stream;

  final _streamController = StreamController<List<Menu>>.broadcast();
  StreamSink<List<Menu>> get _menuSink => _streamController.sink;
  Stream<List<Menu>> get menuStream => _streamController.stream;

  MenuBloc() {
    _eventStream.listen((event) {
      if (event == MenuAction.Fetch) {
        APIManager().fetchMenuStream().listen((snapshot) {
          List<Menu> menuList = [];
          for (Menu todo in snapshot) {
            menuList.add(todo);
          }
          menuList.reversed;
          _menuSink.add(menuList);
        });
      }
    });
  }

  @override
  void dispose() {
    _eventController.close();
    _streamController.close();
  }
}
