import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/popular_model.dart';
import 'package:homechef/screens/recipe_screen.dart';

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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipePage(
              recipe: populars[index],
            )
          ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[ 
            Container(
              width: MediaQuery.of(context).size.width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  child: Image.network(
                    populars[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
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
                    // Colors.black.withOpacity(0.7),
                    Colors.transparent,
                    // Colors.transparent,
                    // Color(0xffFCD966),
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: [
                    // 0.0,
                    // 0.2,
                    0.5,
                    1.0
                  ])
              ),
            ),

            Positioned(
              bottom: 10.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, bottom: 10.0),
                  child: AutoSizeText(
                    populars[index].name,
                    maxFontSize: 35,
                    maxLines: 1,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 10.0,
                        ),
                      ],
                      fontSize: 65.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                )
              ),
            )
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
    height: isActive ? 8 : 5,
    width: isActive ? 8 : 5,
    decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.yellow,
        borderRadius: BorderRadius.all(Radius.circular(12))),
  );
}

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.width * 0.5;

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