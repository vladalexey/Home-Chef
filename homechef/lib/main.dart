import 'package:flutter/material.dart';
import 'package:homechef/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Home Chef',
        theme: ThemeData(
          // fontFamily: 'Roboto',
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Home Chef'),
      ),
    );
  }
}

