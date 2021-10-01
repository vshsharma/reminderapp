import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/util/Constants.dart';

class DatePickerView extends StatefulWidget {
  final ValueChanged<String> onDateTimeChanged;

  const DatePickerView({Key key, this.onDateTimeChanged}) : super(key: key);

  @override
  _DatePickerViewState createState() => _DatePickerViewState();
}

class _DatePickerViewState extends State<DatePickerView> {
  @override
  Widget build(BuildContext context) {
    return dateTimePickerBuilder(context);
  }

  DateTimePicker dateTimePickerBuilder(BuildContext context) {
    return DateTimePicker(
        type: DateTimePickerType.dateTime,
        decoration: kDatePickerViewDecoration,
        initialValue: '',
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: 'Date',
        onChanged: (val) async {
          widget.onDateTimeChanged(val);
        },
        validator: (val) {
          return null;
        },
        onSaved: (val) {});
  }
}
