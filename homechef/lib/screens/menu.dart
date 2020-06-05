import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:homechef/screens/auth/login.dart';
import 'package:homechef/widgets/helpers/auth-helpers.dart';
import 'package:homechef/widgets/helpers/menu_clipper.dart';

class Menu extends StatefulWidget {
  final String username;
  Menu({@required this.username});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isCollapsed = true;
  double screenWidth;
  final _animationDuration = const Duration(milliseconds: 500);
  Animation<double> _animation;
  final AuthHelper authHelper = AuthHelper();

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onIconPressed() {
    if (_animationController.isCompleted) {
      setState(() {
        isCollapsed = true;
        _animationController.reverse();
      });
    } else {
      setState(() {
        isCollapsed = false;
        _animationController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          curve: Curves.decelerate,
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isCollapsed ? -screenWidth : 0,
          right: isCollapsed ? screenWidth - 45 : screenWidth * 0.2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.yellow[700],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.white,
                        ),
                        radius: 20,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        (widget.username != null)
                            ? widget.username
                            : "Quan Phan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Ionicons.ios_log_out),
                        onPressed: () {
                          authHelper.logout();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -1),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  onHorizontalDragEnd: (_) {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.yellow[700],
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.amber[800],
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
