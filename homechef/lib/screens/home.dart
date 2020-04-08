import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_icons/flutter_icons.dart';
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

  @override
  Widget build(BuildContext context) {

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
}
