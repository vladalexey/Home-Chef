import 'package:flutter/material.dart';
import 'package:homechef/models/exclude_ingredients.dart';

class ExclOptionPage extends StatefulWidget {
  @override
  _ExclOptionPageState createState() => _ExclOptionPageState();
}

class _ExclOptionPageState extends State<ExclOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        runSpacing: 0.0,
        spacing: 12.0,
        children: List.generate(exclIngredients.length, (int index) {
          return Chip(
            backgroundColor: Colors.red[200],
            label: Text(exclIngredients[index].name),
          );
        }),
      ),
    );
  }
}