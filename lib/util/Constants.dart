import 'dart:ui';

import 'package:flutter/material.dart';

var kStyleBold = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.black,
);

var kStyleNormal = TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 18,
  color: Colors.black,
);

var kStyleDatePickerLabel = TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 12,
  color: Colors.white,
);

var kReminderTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

var kDateTimeStyle = TextStyle(
  color: Colors.white,
  fontSize: 15.0,
  fontWeight: FontWeight.normal,
);

var kTextCompletedStyle = TextStyle(
  decoration: TextDecoration.lineThrough,
  color: Colors.white,
);

var kTextInCompletedStyle =
    TextStyle(decoration: TextDecoration.none, color: Colors.white);

var kTextInputDecoration = InputDecoration(
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  hintText: 'Enter reminder here',
  hintStyle: kReminderTextStyle,
  fillColor: Colors.red.shade800,
  filled: true,
);

var kDatePickerViewDecoration = InputDecoration(
  hintText: 'Select date and time',
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  hintStyle: kDateTimeStyle,
  fillColor: Colors.red.shade800,
  filled: true,
);

const double kTitleFontSize = 35.0;
const double kLineSeparatorHeight = 25.0;
const double kSubTitleFontSize = 20.0;
const double kSidePadding = 20.0;
const double kTopPadding = 40.0;
const double kDotBottomPadding = 20.0;
const double kScreenTitleFont = 20.0;
const double kImagePadding = 20.0;
const double kScreenTitleSeparator = 15.0;
const double kListItemPadding = 10.0;
const double kTextFieldHeight = 30.0;
const double kTextFieldWidth = 5.0;
const double kButtonSidePadding = 30.0;
const double kButtonTopPadding = 15.0;
const int kPageLength = 8;

Color menuColor = const Color(0xFF616875);
Color subMenuColor = const Color(0xFF4E83EB);

final List<Color> colorShades = <Color>[
  Colors.red.shade900,
  Colors.red.shade800,
  Colors.red.shade700,
  Colors.red.shade600,
  Colors.red.shade500,
  Colors.red.shade400,
];

final List<Color> priorityColor = <Color>[
  const Color(0xFFB13023),
  const Color(0xFFB13423),
  const Color(0xFFB94428),
  const Color(0xFFBF5B2C),
  const Color(0xFFC47832),
  const Color(0xFFCC963A),
  const Color(0xFFD8B243),
];
