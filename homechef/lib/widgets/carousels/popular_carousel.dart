import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/models/popular_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/screens/recipe_screen.dart';
import 'package:homechef/widgets/popular_recipes.dart';
import 'package:homechef/widgets/rating_stars.dart';

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
    controller =
        PageController(initialPage: currentPage, viewportFraction: 0.9);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  GestureDetector _buildPage(List<Recipe> populars, double height, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RecipePage(
                      recipe: populars[index],
                    )));
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(children: <Widget>[
                Positioned(
                  top: 0.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: height * 1.1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                              color: Colors.grey[300])
                        ],
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints.expand(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: height * 0.7,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(18.0),
                                topLeft: Radius.circular(18.0)),
                            child: Image.network(
                              populars[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 5.0, 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                // color: Colors.yellow
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 3.0),
                                          child: Text(
                                            populars[index].name,
                                            maxLines: 1,
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                color: Colors.grey[900],
                                                letterSpacing: 0.1),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0, right: 0.0),
                                            child: RatingStars(
                                              rating: populars[index].rate,
                                              color: Colors.yellow[600],
                                              borderColor: Colors.grey[100],
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7.0, top: 5.0, right: 0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Chip(
                                            backgroundColor: Colors.grey[50],
                                            label: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.timer,
                                                  size: 20.0,
                                                  color: Colors.grey[400],
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  populars[index]
                                                          .cookTime
                                                          .toString() +
                                                      " mins",
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.3,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Chip(
                                            backgroundColor: Colors.grey[50],
                                            label: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                
                                                Icon(
                                                  Ionicons.ios_flame,
                                                  size: 20.0,
                                                  color: Colors.grey[400],
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  populars[index]
                                                          .calories
                                                          .toInt()
                                                          .toString() +
                                                      " cal",
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.3,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
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
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: isActive ? 6 : 4,
      width: isActive ? 6 : 4,
      decoration: BoxDecoration(
        color: isActive ? Colors.amber[400] : Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // border: Border.all(color: isActive ? Colors.amber[300] : Colors.grey[600])
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool errorGetPopular = false;

    double height = MediaQuery.of(context).size.width * 0.55;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            height: height * 1.25,
            child: (newPopulars.length == 0 || errorGetPopular)
                ? FutureBuilder<List<Recipe>>(
                    future: getPopularRecipes(4),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasData) newPopulars = snapshot.data;
                          if (snapshot.hasError) errorGetPopular = true;
                          break;

                        default:
                      }

                      return PageView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return _buildPage(
                              (newPopulars.length != 0)
                                  ? newPopulars
                                  : populars,
                              height,
                              index);
                        },
                        onPageChanged: (int index) {
                          getChangedPage(index);
                        },
                        itemCount: (newPopulars.length != 0)
                            ? newPopulars.length
                            : populars.length,
                        controller: controller,
                      );
                    },
                  )
                : PageView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return _buildPage(
                          (newPopulars.length != 0) ? newPopulars : populars,
                          height,
                          index);
                    },
                    onPageChanged: (int index) {
                      getChangedPage(index);
                    },
                    itemCount: (newPopulars.length != 0)
                        ? newPopulars.length
                        : populars.length,
                    controller: controller,
                  )),
        SizedBox(
          height: 5.0,
        ),
        SizedBox(
          height: 10.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0;
                  i <
                      ((newPopulars.length != 0)
                          ? newPopulars.length
                          : populars.length);
                  i++)
                if (i == currentPage) ...[circleBar(true)] else
                  circleBar(false),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}
