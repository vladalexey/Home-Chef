import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/models/ingredients/ingredient_model.dart';
import 'package:homechef/models/instructions/instruction_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/screens/search_screen.dart';
import 'package:homechef/widgets/rating_stars.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  RecipePage({this.recipe});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  List<IconData> iconCards = [
    FontAwesomeIcons.clock,
    FontAwesomeIcons.utensils,
    Ionicons.ios_flame
  ];

  String parseIngredients(List<Ingredient> ingredients) {
    String res = '';

    for (var ingredient in ingredients) {
      res = res +
          ingredient.name.substring(0, 1).toUpperCase() +
          ingredient.name.substring(1) +
          '\n\n';
    }
    return res;
  }

  String parseAmount(List<Ingredient> ingredients) {
    String res = '';

    for (var ingredient in ingredients) {
      res = res +
          ingredient.amount.toString() + ' ' +
          ingredient.unit +
          '\n\n';
    }
    return res;
  }

  String parseInstruction(List<Instruction> instructions) {
    String res = '';

    for (var index = 1; index <= instructions.length; index++) {
      res = res + '\u2022 \t\t' + instructions[index - 1].instruction + '\n\n';
    }
    return res;
  }

  Widget displayIngredientList() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
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
                    color: Colors.grey[400],
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
      // color: Colors.blue,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            child: (widget.recipe.imageUrl.contains("asset"))
                ? Image(image: AssetImage(widget.recipe.imageUrl))
                : Image.network(
                    widget.recipe.imageUrl,
                    fit: BoxFit.cover,
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
                    Colors.grey[700].withOpacity(0.2),
                    Colors.black.withOpacity(0.8),
                  ],
                      stops: [
                    0.0,
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
            bottom: MediaQuery.of(context).size.height * 0.1,
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
                        child: AutoSizeText(
                          widget.recipe.name,
                          maxFontSize: 55,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 10.0,
                                ),
                              ],
                              fontSize: 65.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 1),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: RatingStars(rating: widget.recipe.rate),
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
      widget.recipe.cookTime.toString() + "\'",
      widget.recipe.servings.toString() + " servings",
      widget.recipe.calories.toString() + " cal"
    ];

    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(40.0)),
        height: height * 0.65,
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
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  blurRadius: 6.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(4.0, 2.0))
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    iconCards[idx],
                                    size: 20.0,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    nameCards[idx],
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[800]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ]),
              ),

              SizedBox(
                height: 20.0,
              ),

              TabBar(
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

              // SizedBox(
              //   height: 5.0,
              // ),

              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  FutureBuilder<List>(
                      future: getIngredients(widget.recipe),
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
                        print(snapshot.data);

                        if (snapshot.hasError)
                          return ErrorWidget(snapshot.error);
                        if (snapshot.hasData) {
                          return displayIngredientList();
                        } else {
                          return Center(
                            child: new Container(
                                child: const CircularProgressIndicator()),
                          );
                        }
                      }),
                  FutureBuilder<List>(
                      future: getInstructions(widget.recipe),
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
                        print(snapshot.data);

                        if (snapshot.hasError)
                          return ErrorWidget(snapshot.error);
                        if (snapshot.hasData) {
                          return displayInstructionList();
                        } else {
                          return Center(
                            child: Container(
                                child: const CircularProgressIndicator()),
                          );
                        }
                      }),
                ]),
              )
            ]));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
