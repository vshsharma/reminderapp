import 'package:flutter/material.dart';
import 'package:flutter_todo/util/Constants.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            Text(
              'Loading data, Please wait',
              style: kStyleNormal.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
