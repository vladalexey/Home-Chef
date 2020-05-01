import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/screens/recipe_screen.dart';
import 'package:homechef/screens/search_screen.dart';
import 'package:homechef/widgets/rating_stars.dart';

class DietPage extends StatefulWidget {
  final Diet diet;
  DietPage({this.diet});

  @override
  _DietPageState createState() => _DietPageState();
}

class _DietPageState extends State<DietPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  Animation curve;
  ScrollController _scrollController;
  bool isScrollDown = false;
  bool isShow = true;
  bool initScreen = true;
  double mediaWidth;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollDown) {
          initScreen = false;
          isScrollDown = true;
          isShow = false;
          _controller.forward();
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollDown) {
          isScrollDown = false;
          isShow = true;
          _controller.reverse();
        }
      }
    });

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    curve = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget topPart() {
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Container(
            height: animation.value,
            width: mediaWidth,
            child: Stack(
              children: <Widget>[
                Container(
                  height: animation.value,
                  width: mediaWidth,
                  child: Hero(
                    tag: widget.diet.imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                      child: Image(
                        image: AssetImage(widget.diet.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: animation.value,
                  width: mediaWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.transparent,
                            Colors.black.withOpacity(0.9),
                          ],
                          stops: [
                            0.0,
                            0.5,
                            1.0
                          ])),
                ),
                Positioned(
                  top: 30.0 + (animation.value - mediaWidth * 0.5) * 0.2,
                  child: Container(
                    width: mediaWidth,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 30.0,
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.search),
                                iconSize: 30.0,
                                color: Colors.white,
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SearchScreen())),
                              ),
                              IconButton(
                                icon: Icon(Icons.sort),
                                iconSize: 30.0,
                                color: Colors.white,
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  child: Container(
                    width: mediaWidth,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, bottom: 0.0, right: 15.0),
                              child: SizedBox(
                                width: mediaWidth * 0.5,
                                child: Divider(
                                  height: 2.0,
                                  color: Colors.yellow[500],
                                  thickness: 3.0,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, bottom: 0.0, right: 15.0),
                              child: AutoSizeText(
                                widget.diet.name,
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.2),
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget categoriesListBuilder() {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
          itemCount: widget.diet.recipes.length,
          itemBuilder: (BuildContext context, int index) {
            Recipe recipe = widget.diet.recipes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RecipePage(
                              recipe: recipe,
                            )));
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                    height: 170.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(150.0, 20.0, 20.0, 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 120.0,
                            child: Text(
                              recipe.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),

                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.timer, size: 20.0, color: Colors.grey[400],),
                                        SizedBox(width: 5.0,),
                                        Text(
                                          recipe.cookTime.toString() + " mins",
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14.0,
                                              letterSpacing: 0.3,
                                              fontWeight: FontWeight.w700
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    RatingStars(
                                      rating: recipe.rate,
                                      color: Colors.yellow[600],
                                      borderColor: Colors.grey[200],
                                    ),
                                  ],
                                ),
                              ]),

                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    top: 15.0,
                    bottom: 15.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        width: 150.0,
                        image: AssetImage(
                          recipe.imageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaWidth = MediaQuery.of(context).size.width;

    animation =
        Tween(begin: mediaWidth * 0.7, end: mediaWidth * 0.5).animate(curve)
          ..addListener(() {
            setState(() {});
          });

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          setState(() {});
        }
      },
      child: new Scaffold(
          body: Stack(children: <Widget>[
        Column(
          children: <Widget>[topPart(), categoriesListBuilder()],
        ),
      ])),
    );
  }
}
