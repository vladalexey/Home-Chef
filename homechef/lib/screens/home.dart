import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          Stack(
            children: <Widget>[

              Column(
                children: <Widget>[
                  // SizedBox(height: 40.0),
                  PopularCarouselPage(),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 70.0
                ),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,

                  children: <Widget>[
                    Center(

                      // SEARCH BAR
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)
                            ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                                      offset: Offset(0, 10),
                                      blurRadius: 20,
                                      spreadRadius: 3
                            )]
                        ),

                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          color: Colors.blue,
                          elevation: 20.0,
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(30.0),

                          child: TextField(
                            cursorColor: Colors.amber,
                            style: TextStyle(height: 1.2),
                            decoration: InputDecoration(
                              
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xff383838),
                              ),
                              contentPadding: EdgeInsets.only(left: 50.0, top: 0.0, bottom: 0.0),
                              hintText: 'Search recipes, cuisine, dish',
                              hintMaxLines: 1,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30.0),
                                ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 
                      MediaQuery.of(context).size.width * 0.28
                    ),

                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
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
                                  fontWeight: FontWeight.bold,
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
              )
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
      )
    );
  }
}
