import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/popular_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/screens/cuisine_screen.dart';

class PopularCarouselPage extends StatefulWidget {

  @override
  _PopularCarouselPageState createState() => _PopularCarouselPageState();
}

class _PopularCarouselPageState extends State<PopularCarouselPage> {

  int currentPage = 0;
  PageController controller;

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: currentPage);
  }

  GestureDetector _buildPage(double height, int index) {

    return GestureDetector(
      onTap: () => print('Popular'),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[ 
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image(
                  image: AssetImage(populars[index].imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
                
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.transparent,
                    Colors.transparent,
                    Color(0xffFCD966),
                  ],
                  stops: [
                    0.0,
                    0.2,
                    0.5,
                    1.0
                  ])
              ),
            ),
          ]
        ),
      ),
    );
  }
  
  void getChangedPage(int index) {
    currentPage = index;
    setState(() {});
  }

  Widget circleBar(bool isActive) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 8),
    height: isActive ? 12 : 8,
    width: isActive ? 12 : 8,
    decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.yellow,
        borderRadius: BorderRadius.all(Radius.circular(12))),
  );
}

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.width * 0.7;

    return Column(
      children: <Widget>[
  
        Stack(
          children: <Widget>[
            Container(
              height: height,
              child: PageView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return _buildPage(height, index);
                },
                onPageChanged: (int index) {
                  getChangedPage(index);
                },
                itemCount: populars.length,
                controller: controller,
              )
            ),

            Container(
              height: height,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 35),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          for (int i = 0; i < populars.length; i++)
                            if (i == currentPage) ...[circleBar(true)] else
                              circleBar(false),
                              
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}