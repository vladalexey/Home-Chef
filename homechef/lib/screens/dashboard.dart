import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/widgets/carousels/cuisine_carousel.dart';
import 'package:homechef/widgets/carousels/diet_carousel.dart';
import 'package:homechef/widgets/carousels/popular_carousel.dart';
import 'package:homechef/widgets/carousels/time_carousel.dart';
import 'package:homechef/widgets/coming_feature.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  Animation curve;
  ScrollController _scrollController;
  bool isScrollDown = false;
  bool isShow = true;
  bool initScreen = true;

  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 350);

  List<String> suggestionList = [
    'Vietnamese',
    'Top 10',
    'New Vegan Recipes',
    'Discovery',
    'Explore Europe',
    'Grandma Style',
    'Best Cookies'
  ];
  List<Color> suggestionListColors = [
    Colors.amber[300],
    Colors.amber,
    Colors.deepOrange[300],
    Colors.yellow[700],
    Colors.orange,
    Colors.amber[300],
    Colors.deepOrange[300]
  ];

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset < 40)
        _controller.reverse();
      else
        _controller.forward();
    });

    _controller = AnimationController(vsync: this, duration: duration);

    curve = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    animation = Tween(begin: 40.0, end: 0.0).animate(curve);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget buildGradientTopCarousel() {
    return Padding(
      padding: EdgeInsets.only(left: 2.0, right: 20.0, top: 25.0, bottom: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                child: Text(
                  'Most Trending',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      // letterSpacing: -0.5,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, top: 5.0, bottom: 0.0),
                child: Text(
                  'Don\'t miss out on the latest recipes',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                    // letterSpacing: -0.5,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget introPart() {
    return Container(

      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: Text(
              "What would you like to make?",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontSize: 27,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget suggestionsBuilder() {
    return Container(
      color: Colors.white,
      height: 35.0,
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Scrollbar(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return WarningComingFeature();
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        backgroundColor: Colors.yellow[600],
                        label: Text(
                          suggestionList[index],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                      ),
                    ));
              }),
        ),
      ),
    );
  }

  Widget homeScreen() {
    return Stack(
      children: <Widget>[
        Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.white,
        ),
        Scrollbar(
          child: ListView(
            padding: EdgeInsets.only(left: 10.0),
            controller: _scrollController,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              introPart(),
              suggestionsBuilder(),
              Container(color: Colors.white, child: buildGradientTopCarousel()),
              Container(color: Colors.white, child: PopularCarouselPage()),
              SizedBox(
                height: 10.0,
              ),
              CuisineCarousel(),
              SizedBox(height: 25.0),
              DietCarousel(),
              SizedBox(height: 15.0),
              TimeCarousel(),
            ],
          ),
        ),
      ],
    );
  }

  Widget appTitle() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: animation.value,
              child: Chip(
                backgroundColor: Colors.yellow[50],
                label: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.hackerrank,
                          color: (animation.value == 40.0)
                              ? Colors.amber[400]
                              : Colors.transparent,
                        ),
                        Text(
                          'omeChef',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: (animation.value == 40.0)
                                      ? Colors.amber[300]
                                      : Colors.transparent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0)),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> appBarActions() {
    return [
      Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: ClipOval(
            child: Container(
              // color: Colors.yellow[50],
              height: 30.0,
              width: 35.0,
              child: FittedBox(
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 35.0,
                    color: Colors.amber[700],
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SearchScreen())),
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          title: appTitle(),
          actions: appBarActions(),
          backgroundColor: Colors.yellow[600],
          elevation: 0.0,
          leading: Container()),
      body: homeScreen(),
    );
  }
}
