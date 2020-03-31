import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/ingredients/ingredient_list_model.dart';
import 'package:homechef/models/ingredients/ingredient_model.dart';
import 'package:homechef/models/instructions/instruction_list_model.dart';
import 'package:homechef/models/instructions/instruction_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/screens/recipe_screen.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // double _searchContainerHeight = 0.0;
  // double _iconHeight = 80.0;
  final SearchBarController<Recipe> searchController = SearchBarController(); 

  Future<List<Recipe>> search(String text) async {

    List<Recipe> apiResult = [];
    List<Recipe> foundResult = [];

    // Get list recipe IDs with search text
    final searchResult = await http.get('https://api.spoonacular.com/recipes/search?query=' + text + 
      '&number=5&apiKey=9f7bda2769fc41088b86b77db2d45ef1');

    if (searchResult.statusCode == 200) {

      final Map<String, dynamic> result = json.decode(searchResult.body);
      
      for (Map<String, dynamic> obj in result['results']) {

        List<Instruction> parsedInstruction;
        List<Ingredient> parsedIngredients;

        final instructionResp = await http.get('https://api.spoonacular.com/recipes/' + obj['id'].toString() + '/analyzedInstructions?apiKey=9f7bda2769fc41088b86b77db2d45ef1');
       
        if (instructionResp.statusCode == 200) {
          parsedInstruction = InstructionList.fromJson(json.decode(instructionResp.body)).instructions;
        } else {
          print('Failed to get instructions ' + instructionResp.statusCode.toString());
        }

        final ingredientResp = await http.get('https://api.spoonacular.com/recipes/' + obj['id'].toString() + '/ingredientWidget.json?apiKey=9f7bda2769fc41088b86b77db2d45ef1');
        
        if (ingredientResp.statusCode == 200) {
          parsedIngredients = IngredientList.fromJson(json.decode(ingredientResp.body)).ingredients;
        } else {
          print('Failed to get ingredients ' + ingredientResp.statusCode.toString());
        }

        Recipe newRecipe = new Recipe(
          id: obj['id'].toString(),
          imageUrl: 'https://spoonacular.com/recipeImages/' + obj['id'].toString() + '-556x370.jpg' ,
          name: obj['title'],
          cookTime: obj['readyInMinutes'],
          ingredients: parsedIngredients,
          instruction: parsedInstruction
        );

        apiResult.add(
          newRecipe
        );
      }

      // for (Recipe recipe in apiResult) {
      //   if (recipe.name.contains(text)) {
      //     foundResult.add(recipe);
      //   }
      // }

    } else {
      print('Failed to load Recipe. Resp Code: ' + searchResult.statusCode.toString());
    }

    return apiResult;
  }

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  Widget buildSearchRecipeResult(Recipe recipe) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RecipePage(
            recipe: recipe,
          )
        )
      ),
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
              padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        child: AutoSizeText(
                          recipe.name,
                          maxFontSize: 18.0,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          AutoSizeText(
                            '${recipe.id}',
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Recipe ID',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    recipe.cookTime.toString() + ' minutes',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  _buildRatingStars(recipe.rate),
                  SizedBox(height: 10.0),
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
              child: Image.network(
                recipe.imageUrl,
                width: 110.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: GestureDetector(
          onTap: () {
            searchController.clear();
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          child: SafeArea(
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
                              spreadRadius: 5
                    )]
                ),

                width: MediaQuery.of(context).size.width,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SearchBar<Recipe>(

                    searchBarStyle: SearchBarStyle(
                      backgroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      padding: EdgeInsets.only(left: 15.0)
                    ),

                    icon: Icon(Icons.search),
                    hintText: 'Search recipes, cuisines, diets, ...',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    shrinkWrap: true,
                    headerPadding: EdgeInsets.all(5.0),
                    searchBarPadding: EdgeInsets.all(15.0),
                    searchBarController: searchController,
                    cancellationWidget: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: Center(child: 
                              IconButton(
                                onPressed: () {
                                  searchController.clear();
                                  FocusScope.of(context).unfocus();
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.cancel))
                            ),
                        ),
                      ),
                    ),
                    onError: (Error error) { return Text(error.toString());},
                    onCancelled: () {
                      print('Cancel Search');
                    },

                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            ),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.sortAlphaDown, 
                              color: Colors.black87,
                            ),
                            onPressed: () {
                              searchController.sortList((Recipe a, Recipe b) {
                                return a.name.compareTo(b.name);
                              });
                            },
                          ),
                        ),

                        SizedBox(width: 20.0,),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            ),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.sortAlphaUp, 
                              color: Colors.black87,
                            ),
                            onPressed: () {
                              searchController.sortList((Recipe a, Recipe b) {
                                return b.name.compareTo(a.name);
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    debounceDuration: Duration(milliseconds: 500),
                    emptyWidget: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            child: Text(
                              'No results found',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white
                              ),
                              )
                            ),
                        ),
                      ],
                    ),

                    minimumChars:0,
                    onSearch: search, 
                    onItemFound: (Recipe recipe, int index) {

                      return Container(
                        child: buildSearchRecipeResult(recipe)
                      );
                    },
                  ),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}