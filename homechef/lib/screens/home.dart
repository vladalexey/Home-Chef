import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:homechef/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/widgets/cuisine_carousel.dart';
import 'package:homechef/widgets/diet_carousel.dart';
import 'package:homechef/widgets/popular_carousel.dart';
import 'package:homechef/widgets/time_carousel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget buildGradientTopCarousel() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 70.0,
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,

        children: <Widget>[

          SizedBox(height: 
            MediaQuery.of(context).size.width * 0.4
          ),

          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Divider(
                      height: 2.0,
                      // color: Colors.yellow[700],
                      // color: Color(0xff383838),
                      color: Colors.yellow[500],
                      thickness: 3.0,
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 20.0),
                    child: Text(
                      'Most popular',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController (

      length:3,
      child: new Scaffold(

        body: TabBarView(
          children: <Widget>[
            
            Stack(
              children: <Widget>[

                Column(

                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    Stack(
                      children: <Widget>[

                        PopularCarouselPage(),
                        buildGradientTopCarousel(),

                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.black54,
                              ),
                              height: 60.0,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 2.0
                                    ),
                                  child: IconButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SearchScreen())
                                    ),
                                  
                                    iconSize: 30.0,
                                    color: Colors.white,
                                    icon: Icon(Icons.search)),
                                ),
                              )
                              ,),
                          ),
                        ),
                        
                      ],
                    ),

                    Expanded(
                          child: ListView(
                            children: <Widget>[
                              CuisineCarousel(),
                              SizedBox(height: 5.0),
                              DietCarousel(),
                              SizedBox(height: 5.0),
                              TimeCarousel()
                            ],
                          ),
                        ),
                  ],
                ),
                
              ],
            ),

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
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.yellow,
          ),
          backgroundColor: Colors.white,
      ),
    );
  }
}
