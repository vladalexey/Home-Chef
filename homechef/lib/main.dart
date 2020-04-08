import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:homechef/screens/home.dart';
import 'package:homechef/screens/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Row appTitle = Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget> [
      Image.asset(
        'assets/imgs/appLogo3.png',
        fit: BoxFit.contain,
        height: 120.0,
      ),
  ]);
  
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
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData(),
        home: DefaultTabController (

          length:3,
          child: new Scaffold(

            appBar: AppBar(
              elevation: 10.0,
              backgroundColor: Colors.yellow[600],
              title: appTitle,
              actions: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    child: IconButton(
                      onPressed: () => Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (_) => SearchScreen())),
                      icon: Icon(Icons.search),
                      iconSize: 30.0,
                      color: Colors.black87
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Ionicons.ios_log_out),
                        iconSize: 28.0,
                        color: Colors.black87
                      ),
                    ),
                  ),
                ),

              ],

            ),

            body: TabBarView(
              children: <Widget>[

                MyHomePage(title: 'Home Chef'),

                new Container(
                  color: Colors.yellow,
                ),
                new Container(
                  color: Colors.orange,
                ),
              ],
            ),

            bottomNavigationBar: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.person),
                  ),
                  Tab(icon: new Icon(Icons.favorite),)
                ],
                
                labelColor: Colors.amber[300],
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.amber[300],
              ),
              backgroundColor: Colors.white,
          ),
        ) 
        
        
      ),
    );
  }
}

