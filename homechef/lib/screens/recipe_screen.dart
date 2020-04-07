import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/cuisine_model.dart';
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

class _RecipePageState extends State<RecipePage> {
  
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
      res = res + index.toString() + '. ' + instructions[index - 1].instruction + '\n\n';
    }
    return res;
  }

  Widget displayIngredientList() {
    return Container(
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
                            fontWeight: FontWeight.w600,
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
    );
  }

  Widget displayInstructionList() {
    return Container(
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
                            fontWeight: FontWeight.w600,
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
    );
  }

  Widget displayTopPart() {
    return Stack(
      children: <Widget>[

        Container(
          height: MediaQuery.of(context).size.width * 0.7,
          width: MediaQuery.of(context).size.width,
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.network(
              widget.recipe.imageUrl,
              // image: AssetImage(widget.recipe.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        Container(
          height: MediaQuery.of(context).size.width * 0.7,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
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
                0.3,
                1.0
              ])
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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchScreen())
                    ),
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
        ),

        Positioned(
          bottom: 20.0,
          left: 20.0,
          right: 20.0,
          child: Column(
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
                        thickness: 3.0,
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.clock,
                            color: Colors.white,),
                          SizedBox(width: 10.0,),
                          Text(
                            widget.recipe.cookTime.toString() + ' \'',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0)
                          ),
                        ],
                      ),
                    ),

                    Flexible(
                      child: RatingStars(rating: widget.recipe.rate),
                    ),

                  ],
                )
                
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          setState(() {});
        }
      },
      child: new Scaffold(
        body: Column(
          children: <Widget>[
            
            displayTopPart(),

            Expanded(
              child: ListView(
                children: <Widget>[
                  
                  displayIngredientList(),     
                  SizedBox(height: 15.0),
                  displayInstructionList(),

                ],
              ),
            ),

          ],
        )
      ),
    );
  }
}