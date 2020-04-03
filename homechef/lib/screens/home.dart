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

  GlobalKey topPartKey = GlobalKey();
  double _searchBarWidth;

  Widget buildGradientTopCarousel() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 30.0,
        bottom: 5.0
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,

        children: <Widget>[

          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  'Most trending',
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

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Divider(
                  height: 2.0,
                  color: Colors.yellow[500],
                  thickness: 3.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget searchBarHome() {
    return GestureDetector(
      onTap: () {

        setState(() {
          _searchBarWidth = 0.0;
        });
        
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (_) => SearchScreen()
          )
        );
      },
      
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(3, 5),
                blurRadius: 20,
                spreadRadius: 3
              )
            ],
            color: Colors.yellow[200],
            
          ),
          height: 60.0,
          width: 60.0,
          child: Align(
            alignment: Alignment.center,
            child: Icon(Icons.search,
              size: 30.0,
              color: Colors.black87),
            ),
          ),
      )

    );
  }

  double getPosTopPart() {
    RenderBox topPart = topPartKey.currentContext.findRenderObject();
    return topPart.localToGlobal(Offset.zero).dx;
  }

  @override
  Widget build(BuildContext context) {

    _searchBarWidth = MediaQuery.of(context).size.width * 0.2;

    return DefaultTabController (

      length:3,
      child: new Scaffold(
        
        floatingActionButton: searchBarHome(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

        body: TabBarView(
          children: <Widget>[
            
            SafeArea(
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      
                      buildGradientTopCarousel(),

                      PopularCarouselPage(),
                      SizedBox(height: 15.0),
                      CuisineCarousel(),
                      SizedBox(height: 5.0),
                      DietCarousel(),
                      SizedBox(height: 5.0),
                      TimeCarousel(),
                      
                    ],
                  ),
                  
                ],
              ),
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
