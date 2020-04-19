import 'package:flutter/material.dart';
import 'package:homechef/models/time_model.dart';

class TimeOptionPage extends StatefulWidget {
  @override
  _TimeOptionPageState createState() => _TimeOptionPageState();
}

class _TimeOptionPageState extends State<TimeOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        runSpacing: 0.2,
        spacing: 12.0,
        children: List.generate(times.length, (int index) {
          return Chip(
            backgroundColor: Colors.yellow[400],
            label: Text(times[index].name),
          );
        }),
      ),
    );
  }
}