import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/screens/search_screen.dart';
import 'package:homechef/widgets/helpers/recipe_helper.dart';
import 'package:homechef/widgets/rating_stars.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  RecipePage({this.recipe});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController, _scrollControllerIns, _scrollControllerIng;
  AnimationController _controller;
  Animation<double> animation;
  Animation curve;
  double height, width;
  bool isScrollDown = false;
  bool isShow = true;
  bool initScreen = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollControllerIns = ScrollController();
    _scrollControllerIng = ScrollController();

    _scrollController.addListener( () {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollDown) {
          initScreen = false;
          isScrollDown = true;
          isShow = false;  
          _controller.forward();
        }
      }
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollDown) {
          isScrollDown = false;
          isShow = true;
          _controller.reverse(); 
        }
      }
    });

    _scrollControllerIng.addListener(() {
      if (_scrollControllerIng.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollDown) {
          initScreen = false;
          isScrollDown = true;
          isShow = false;  
          _controller.forward();
        }
      }
      if (_scrollControllerIng.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollDown) {
          isScrollDown = false;
          isShow = true;
          _controller.reverse(); 
        }
      }
    });

    _scrollControllerIns.addListener( () {
      if (_scrollControllerIns.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollDown) {
          initScreen = false;
          isScrollDown = true;
          isShow = false;  
          _controller.forward();
        }
      }
      if (_scrollControllerIns.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollDown) {
          isScrollDown = false;
          isShow = true;
          _controller.reverse(); 
        }
      }
    });

    _tabController = new TabController(length: 2, vsync: this);
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    
    curve = CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut);
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollControllerIns.dispose();
    _scrollController.dispose();
    _scrollControllerIng.dispose();
    _tabController.dispose();
  }

  List<IconData> iconCards = [
    FontAwesomeIcons.clock,
    FontAwesomeIcons.utensils,
    Ionicons.ios_flame
  ];

  Widget displayIngredientList() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        controller: _scrollControllerIng,
        children: <Widget>[
          // LIST INGREDIENTS
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  parseIngredients(widget.recipe.ingredients),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  parseAmount(widget.recipe.ingredients),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayInstructionList() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        controller: _scrollControllerIns,
        children: <Widget>[
          // LIST INSTRUCTIONs
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
            child: Text(
              parseInstruction(widget.recipe.instruction),
              style: TextStyle(
                height: 1.5,
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget displayTopPart() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: (widget.recipe.imageUrl.contains("asset"))
                  ? Image(image: AssetImage(widget.recipe.imageUrl), fit: BoxFit.cover,)
                  : Image.network(
                      widget.recipe.imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.8),
                  ],
                      stops: [
                    0.0,
                    0.3,
                    1.0
                  ])),
            ),
          ),
          Positioned(
            top: 50.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SearchScreen())),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: 20.0,
            right: 20.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Divider(
                        height: 2.0,
                        color: Colors.yellow[500],
                        thickness: 2.0,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints.loose(Size.fromWidth(
                          MediaQuery.of(context).size.width * 0.8)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 10.0),
                        child: AutoSizeText(widget.recipe.name,
                            maxFontSize: 45,
                            minFontSize: 25,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 45.0,
                                fontWeight: FontWeight.w600,
                              ),
                              color: Colors.white.withOpacity(0.9),
                            )),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, bottom: 15.0, top: 10.0),
                      child: RatingStars(
                        rating: widget.recipe.rate,
                        color: Colors.grey[200],
                        borderColor: Colors.grey[200],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInstructionIngredients(height, width) {
    List<String> nameCards = [
      widget.recipe.cookTime.toString() + " mins",
      widget.recipe.servings.toString() + " servings",
      widget.recipe.calories.truncate().toString() + " cal"
    ];

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta < 0) _controller.forward();
        else if (details.primaryDelta > 0) _controller.reverse(); 
      },
      child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0)),
                height: animation.value,
                width: width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Divider(
                        color: Colors.grey[200],
                        indent: 80.0,
                        endIndent: 80.0,
                        thickness: 3.0,
                      ),
                      SizedBox(height: 0.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              for (var idx = 0; idx < iconCards.length; idx++)
                                Container(
                                  height: width * 0.25,
                                  width: width * 0.25,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.transparent),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            iconCards[idx],
                                            size: 20.0,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            nameCards[idx],
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[800]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ]),
                      ),
                      Divider(
                        indent: 50.0,
                        endIndent: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TabBar(
                          tabs: <Widget>[
                            Tab(
                              child: Text(
                                "Ingredients",
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Directions",
                              ),
                            ),
                          ],
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.yellow,
                          indicatorWeight: 2.0,
                          labelColor: Colors.grey[700],
                          labelStyle: GoogleFonts.overpass(
                              textStyle: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w800)),
                          unselectedLabelStyle: GoogleFonts.overpass(
                              textStyle: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w700)),
                          unselectedLabelColor: Colors.grey[400],
                          controller: _tabController,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(controller: _tabController, children: [
                          displayIngredientList(),
                          displayInstructionList(),
                        ]),
                      )
                    ]));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    animation = Tween(
      begin: height * 0.6, 
      end: height * 0.8,).animate(curve);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          setState(() {});
        }
      },
      child: new Scaffold(
          body: Stack(
        children: <Widget>[
          Positioned(top: 0.0, child: displayTopPart()),
          Positioned(
              bottom: 0.0, child: buildInstructionIngredients(height, width)),
        ],
      )),
    );
  }
}
