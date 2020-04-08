import 'dart:convert';
import 'dart:ui';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:homechef/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/widgets/carousels/cuisine_carousel.dart';
import 'package:homechef/widgets/carousels/diet_carousel.dart';
import 'package:homechef/widgets/carousels/popular_carousel.dart';
import 'package:homechef/widgets/carousels/time_carousel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey topPartKey = GlobalKey();

  Widget buildGradientTopCarousel() {
    return Padding(
      padding: EdgeInsets.only(
        left: 2.0,
        right: 20.0,
        top: 25.0,
        bottom: 5.0
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,

        children: <Widget>[

          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  'Most Trending',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 10.0,
                      ),
                    ],
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    // letterSpacing: -0.5,
                  ),
                ),
              )
            ],
          ),

          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 2.0, bottom: 12.0),
                child: Text(
                  'Don\'t miss out on the latest recipes',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 10.0,
                      ),
                    ],
                    fontSize: 12.0,
                    // fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    // letterSpacing: -0.5,
                  ),
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Divider(
                  height: 1.0,
                  // color: Colors.yellow[500],
                  thickness: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getPosTopPart() {
    RenderBox topPart = topPartKey.currentContext.findRenderObject();
    return topPart.localToGlobal(Offset.zero).dx;
  }

  SafeArea homeScreen() {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Container(color: Colors.grey[200],)
          ),
          Scrollbar(
            child: ListView(
              children: <Widget>[
                
                buildGradientTopCarousel(),

                PopularCarouselPage(),
                // SizedBox(height: 10.0),
                
                Divider(indent: 8.0, endIndent: 8.0,),
                CuisineCarousel(),
                SizedBox(height: 5.0),
                
                Divider(indent: 8.0, endIndent: 8.0,),
                DietCarousel(),
                SizedBox(height: 5.0),
                
                Divider(indent: 8.0, endIndent: 8.0,),
                TimeCarousel(),
                
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Row appTitle = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget> [
        Image.asset(
          'assets/imgs/appLogo3.png',
          fit: BoxFit.contain,
          height: 120.0,
        ),
    ]);

    return DefaultTabController (

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
                    MaterialPageRoute(
                      builder: (_) => SearchScreen())
                  ),
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

            homeScreen(),

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
    ); 
  }
}
