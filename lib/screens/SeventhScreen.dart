import 'package:flutter/material.dart';
import 'package:flutter_todo/util/Constants.dart';

class SeventhScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: EdgeInsets.all(kSidePadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Image.asset('images/cloud.png'),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Use ',
                    style: kStyleNormal.copyWith(fontSize: 30),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'iCloud?',
                          style: kStyleBold.copyWith(fontSize: 30)),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Storing your list in iCloud allows you to keep your dara in sync across your iPhone, iPas and Mac',
                textAlign: TextAlign.center,
                style: kStyleNormal,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // todo
                    },
                    child: Text(
                      'Not Now',
                      style: kStyleNormal,
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // todo
                    },
                    child: Text(
                      'Use iCloud',
                      style: kStyleBold,
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
