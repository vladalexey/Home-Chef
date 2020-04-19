import 'package:flutter/material.dart';
import 'package:homechef/models/include_ingredients.dart';

class InclOptionPage extends StatefulWidget {
  @override
  _InclOptionPageState createState() => _InclOptionPageState();
}

class _InclOptionPageState extends State<InclOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        runSpacing: 0.0,
        spacing: 12.0,
        children: List.generate(inclIngredients.length, (int index) {
          return Chip(
            backgroundColor: Colors.lightGreenAccent[100],
            label: Text(inclIngredients[index].name),
          );
        }),
      ),
    );
  }
}