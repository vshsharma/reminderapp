import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';

class CommonUtil {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void launchPageViewer(
    BuildContext context,
    String id,
  ) {
    Navigator.pushNamedAndRemoveUntil(
        context, id, (Route<dynamic> route) => false);
  }

  void launchScreen(
    BuildContext context,
    String id,
  ) {
    Navigator.pushNamed(context, id);
  }

  void statusNTUData(BuildContext context, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('ntu') != null && prefs.getBool('ntu')) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(id, (Route<dynamic> route) => false);
    } else {
      await prefs.setBool('ntu', true);
    }
  }

  bool isEmail(String string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return false;
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  /// Get different shades of colour for different tasks
  Color getBackGroundColor(String priority) {
    if (priority == 'High') {
      return priorityColor[0];
    } else if (priority == 'Medium') {
      return priorityColor[3];
    } else if (priority == 'Low') {
      return priorityColor[5];
    } else {
      return colorShades[Random().nextInt(5)];
    }
  }
}
