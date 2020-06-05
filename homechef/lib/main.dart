import 'package:flutter/material.dart';
import 'package:homechef/BLoC/bloc_filter_noti.dart';
import 'package:homechef/BLoC/bloc_provider.dart';
import 'package:homechef/screens/auth/login.dart';
import 'package:homechef/screens/menu_dashboard.dart';
import 'package:homechef/widgets/helpers/auth-helpers.dart';
import 'dart:convert' show json, base64, ascii;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final AuthHelper authHelper = AuthHelper();

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: BlocProvider(
        bloc: NotiFilterBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Home Chef',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
              future: authHelper.jwtOrEmpty,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                if (snapshot.data != "") {
                  var str = snapshot.data;
                  var jwt = str.split(".");

                  if (jwt.length != 3) {
                    return LoginPage();
                  } else {
                    var payload = json.decode(
                        ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                    if (DateTime.fromMillisecondsSinceEpoch(
                            payload["exp"] * 1000)
                        .isAfter(DateTime.now())) {
                      return MenuDashboard(username: payload["username"],);
                    } else {
                      return LoginPage();
                    }
                  }
                } else {
                  return LoginPage();
                }
              }),
        ),
      ),
    );
  }
}
