import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/models/ingredients/ingredient_model.dart';
import 'package:homechef/models/instructions/instruction_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/widgets/ingredients.dart';
import 'package:homechef/widgets/instructions.dart';

class RecipePage extends StatefulWidget {

  final Recipe recipe;
  RecipePage({this.recipe});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  bool _visible = false;

  void openSearchBar() {
    setState(() {
      _visible = true;
      });
  }
  
  String parseIngredients( List<Ingredient> ingredients) {

    String res = '';

    for (var ingredient in ingredients) {
      
      res = res + '- ' + ingredient.name + '\n';
    }
    return res;
  }

  String parseInstruction( List<Instruction> instructions) {

    String res = '';

    for (var index = 1; index <= instructions.length; index++) {
      
      res = res + index.toString() + '. ' + instructions[index - 1].instruction + '\n';
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          _visible = false;
          setState(() {});
        }
      },
      child: new Scaffold(
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[

                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: Hero(
                    tag: widget.recipe.imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(
                        widget.recipe.imageUrl,
                        // image: AssetImage(widget.recipe.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                
                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                        Color(0xffFCD966),
                      ],
                      stops: [
                        0.0,
                        0.3,
                        1.0
                      ])
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 70.0
                  ),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      Stack(
                        children: <Widget> [
                          Row(
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
                                    onPressed: () => openSearchBar(),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.sort),
                                    iconSize: 30.0,
                                    color: Colors.white,
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              )
                            ],
                          ),

                          Visibility(
                              visible: _visible,
                              child: Center(
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
                                    autofocus: true,
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
                          ),

                        ],
                      ),

                      SizedBox(height: 
                        MediaQuery.of(context).size.width * 0.45
                      ),

                      Padding(
                          padding: const EdgeInsets.only(left: 15.0),
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0, bottom: 10.0),
                              child: AutoSizeText(
                                widget.recipe.name,
                                maxFontSize: 55,
                                maxLines: 2,
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
                                  color: Color(0xff1D1D1D),
                                ),
                              ),
                            ),
                          )
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
                  Container(

                      // STACK FOR INGREDIENTS
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                            bottom: 5.0,
                            left: 15.0,
                            right: 15.0),
                          child: Stack(
                            children: <Widget>[

                              // LIST INGREDIENTS
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.7,

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 80.0, 
                                        bottom: 10.0,
                                        left: 30.0,
                                        right: 10.0),
                                      child: Text(
                                        parseIngredients(widget.recipe.ingredients),
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing:  1.5,
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                              ),

                              // INGREDIENTS TITLE
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 40.0,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[600],
                                      borderRadius: BorderRadius.circular(30.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),

                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 35.0,),
                                        child: Text(
                                          'Ingredients',
                                          style: TextStyle(
                                            letterSpacing: 1.2,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20.0
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ),

                  SizedBox(height: 15.0),

                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                          left: 15.0,
                          right: 15.0),
                        child: Stack(
                          children: <Widget>[

                            // LIST INSTRUCTIONs
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.7,

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 80.0, 
                                      bottom: 10.0,
                                      left: 30.0,
                                      right: 10.0),
                                    child: Text(
                                      parseInstruction(widget.recipe.instruction),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing:  1.5,
                                        wordSpacing: 1.2
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            ),

                            // INSTRUCTION TITLE
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 40.0,
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[600],
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),

                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 35.0,),
                                      child: Text(
                                        'Instructions',
                                        style: TextStyle(
                                          letterSpacing: 1.2,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20.0
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  
                ],
              ),
            ),

          ],
        )
      ),
    );
  }
}