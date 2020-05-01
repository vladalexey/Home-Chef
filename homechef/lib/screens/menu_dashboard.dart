import 'package:flutter/material.dart';
import 'package:homechef/screens/dashboard.dart';
import 'package:homechef/screens/menu.dart';

final Color backgroundColor = Colors.yellow[600];

class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          MyHomePage(),
          Menu(),
        ],
      ),
    );
  }
}
