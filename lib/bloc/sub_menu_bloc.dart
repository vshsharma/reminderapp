import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/bloc/base_bloc.dart';
import 'package:flutter_todo/model/request_sub_menu.dart';
import 'package:flutter_todo/model/sub_menu.dart';
import 'package:flutter_todo/service/api_manager.dart';

enum SubMenuAction { Fetch }

class SubMenuBloc extends BaseBloc {
  final subMenuCollection = FirebaseFirestore.instance.collection('SubMenus');

  final _eventController = StreamController<RequestSubMenu>();
  StreamSink<RequestSubMenu> get eventSink => _eventController.sink;
  Stream<RequestSubMenu> get _eventStream => _eventController.stream;

  final _streamController = StreamController<List<SubMenu>>.broadcast();
  StreamSink<List<SubMenu>> get _menuSink => _streamController.sink;
  Stream<List<SubMenu>> get menuStream => _streamController.stream;

  SubMenuBloc() {
    _eventStream.listen((event) {
      if (event.event == SubMenuAction.Fetch) {
        APIManager().fetchSubMenuStream(event.menuId).listen((snapshot) {
          List<SubMenu> subMenuList = [];
          for (SubMenu subMenu in snapshot) {
            subMenuList.add(subMenu);
          }
          subMenuList.reversed;
          _menuSink.add(subMenuList);
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
