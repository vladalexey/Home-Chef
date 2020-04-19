import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/BLoC/bloc_filter_noti.dart';
import 'package:homechef/BLoC/bloc_provider.dart';
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
      child: BlocProvider(
        bloc: NotiFilterBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Home Chef',
          theme: ThemeData(
            // Rubik / Poppins / 
            // textTheme: GoogleFonts.rubikTextTheme(
            //   Theme.of(context).textTheme
            // ),
            primarySwatch: Colors.blue,

          ),
          // darkTheme: ThemeData(),
          home: MyHomePage(title: 'Home Chef'),
          
          
        ),
      ),
    );
  }
}

