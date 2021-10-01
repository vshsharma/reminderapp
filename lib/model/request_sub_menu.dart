import 'package:flutter_todo/bloc/sub_menu_bloc.dart';

class RequestSubMenu {
  SubMenuAction event;
  String menuId;

  RequestSubMenu({this.event, this.menuId});
}
