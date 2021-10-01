import 'package:flutter_todo/bloc/reminder_bloc.dart';

class BlockEvent {
  UserAction eventId;
  String id;
  String title;
  bool completed;
  String dateTime;
  String priority;
  String menuId;
  String subMenuId;
  String taskCount;

  BlockEvent(
      {this.eventId,
      this.id,
      this.title,
      this.completed,
      this.dateTime,
      this.priority,
      this.menuId,
      this.subMenuId,
      this.taskCount});
}
