import 'package:flutter/material.dart';

class WarningComingFeature extends StatefulWidget {
  @override
  _WarningComingFeatureState createState() => _WarningComingFeatureState();
}

class _WarningComingFeatureState extends State<WarningComingFeature> {
  @override
  Widget build(BuildContext context) {
    print('Warning');
    return AlertDialog(
      title: Text('Features coming to you ASAP!'),
      elevation: 20.0,
      actions: <Widget>[
        FlatButton(
          child: Text('I\'ll wait patiently. Thanks!'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}