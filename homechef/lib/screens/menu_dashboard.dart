import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:homechef/screens/dashboard.dart';
import 'package:homechef/screens/menu.dart';

final Color backgroundColor = Colors.yellow[600];

class MenuDashboard extends StatefulWidget {

  final String username;
  MenuDashboard({@required this.username});

  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> {

  @override
  Widget build(BuildContext context) {

    for (int idx = 0; idx < 10; idx++ ) print(Faker().food.dish());

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          MyHomePage(),
          Menu(username: widget.username,),
        ],
      ),
    );
  }
}
