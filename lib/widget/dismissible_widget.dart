import 'package:flutter/material.dart';
import 'package:flutter_todo/util/CommonUtil.dart';
import 'package:flutter_todo/util/Constants.dart';

class DismissibleWidget extends StatefulWidget {
  final ValueChanged<String> onActionChanged;
  final item;
  final index;
  final key;

  DismissibleWidget({this.key, this.item, this.index, this.onActionChanged});

  @override
  _DismissibleWidgetState createState() => _DismissibleWidgetState();
}

class _DismissibleWidgetState extends State<DismissibleWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key,
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        setState(() {
          if (direction == DismissDirection.endToStart) {
            widget.onActionChanged('delete');
          } else {
            if (widget.item.completed) {
              CommonUtil().showSnackBar(context, 'Task is already completed');
            } else {
              widget.onActionChanged('updateStatus');
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
        color: widget.item.completed
            ? Colors.black87
            : CommonUtil().getBackGroundColor(widget.item.priority),
        child: ListTile(
          enabled: !widget.item.completed,
          title: Text(widget.item.title,
              style: widget.item.completed
                  ? kTextCompletedStyle
                  : kTextInCompletedStyle),
          subtitle: Text(
            widget.item.dateTime,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
