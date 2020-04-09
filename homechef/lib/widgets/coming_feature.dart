import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WarningComingFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Warning');
    return CupertinoAlertDialog(
      title: Text('Coming soon!'),
      actions: <Widget>[
        FlatButton(
          child: Text('I\'ll wait patiently!', style: TextStyle(color: Colors.white),),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}