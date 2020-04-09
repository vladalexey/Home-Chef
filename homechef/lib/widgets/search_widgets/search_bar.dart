import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/screens/recipe_screen.dart';
import 'package:homechef/screens/search_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:homechef/widgets/rating_stars.dart';
import 'package:http/http.dart' as http;

import '../flappy_search_bar-1.7.2-modified/lib/flappy_search_bar.dart';
import '../flappy_search_bar-1.7.2-modified/lib/search_bar_style.dart';

class SearchBarWidget extends StatefulWidget {

  final SearchBarController<Recipe> searchController;
  final Function() callSearchScreenDiet, callSearchScreenCuisine;
  SearchBarWidget({
    @required this.callSearchScreenDiet, 
    @required this.callSearchScreenCuisine,
    @required this.searchController});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> with TickerProviderStateMixin{

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
  
  bool filterUp = false;

  SearchScreen parent;
  _SearchBarWidgetState({this.parent});

  

  Map<String, bool>  cuisine;
  Map<String, bool>  time;
  
  Future<List<Recipe>> search(String text) async {

    String _diet = '';
    String _cuisine = '';
    String _time = '';

    String apiKey = await getFileData('assets/API_KEY_RAPIDAPI.txt');
    Map<String, String> _headers;

    List<Recipe> apiResult = [];
    List<Recipe> foundResult = [];

    if (dietOptions.containsValue(true)) {
      for (String key in dietOptions.keys) {
        if (dietOptions[key] == true) {
          _diet = '&diet=' + key.substring(0, key.length - 4).toLowerCase();
          break;
        }
      }
    }

    _cuisine = '&cuisine=';

    for (String key in cuisineOptions.keys) {
      if (cuisineOptions[key] == true) {
        _cuisine = _cuisine + key + ',';
      }
    }

    _cuisine = _cuisine.substring(0, _cuisine.length - 1);
    

    // if (time != null) {
    //   _time = '&time=' + time.name;
    // }

    // Get list recipe IDs with search text

    // String baseURL = 'https://api.spoonacular.com';
    String baseURL = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';

    String searchURL = baseURL + '/recipes/search?query=' + text + 
      _cuisine + _diet + _time +
      '&number=5&apiKey=' + apiKey;

    if (searchURL.contains('rapidapi')) {
       _headers = {
        "content-type": "application/json",
        "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "x-rapidapi-key": apiKey,
      };
    }
    final searchResult = await http.get(searchURL, headers: searchURL.contains('rapidapi') ? _headers : null);

    print(searchURL);

    if (searchResult.statusCode == 200) {

      final Map<String, dynamic> result = json.decode(searchResult.body);
      
      for (Map<String, dynamic> obj in result['results']) {

        Recipe newRecipe = new Recipe(
          id: obj['id'].toString(),
          imageUrl: 'https://spoonacular.com/recipeImages/' + obj['id'].toString() + '-556x370.jpg' ,
          name: obj['title'],
          cookTime: obj['readyInMinutes'],
        );

        apiResult.add(
          newRecipe
        );
      }
    } else {
      print('Failed to load Recipe. Resp Code: ' + searchResult.statusCode.toString());
    }

    return apiResult;
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
                    mainAxisSize: MainAxisSize.min,
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
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            AutoSizeText(
                              '${recipe.id}',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            AutoSizeText(
                              'Recipe ID',
                              maxFontSize: 15.0,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    recipe.cookTime.toString() + ' minutes',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  RatingStars(rating: recipe.rate),
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

  Widget buildHeaderRow() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(indent: 10.0, endIndent: 10.0,),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.access_time, 
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        widget.searchController.sortList((Recipe a, Recipe b) {
                          return a.name.compareTo(b.name);
                        });
                      },
                    ),
                    AutoSizeText(
                      'Time',
                      style: TextStyle(color: Colors.grey),
                      maxLines: 1,
                      maxFontSize: 20.0,
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.warning, 
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        widget.callSearchScreenDiet();
                      },
                    ),
                    AutoSizeText(
                      'Diet',
                      style: TextStyle(color: Colors.grey),
                      maxLines: 1,
                      maxFontSize: 20.0,
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.location_on, 
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        widget.callSearchScreenCuisine();
                      },
                    ),
                    AutoSizeText(
                      'Cuisine',
                      style: TextStyle(color: Colors.grey),
                      maxLines: 1,
                      maxFontSize: 20.0,
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        filterUp ? FontAwesomeIcons.sortAlphaUp : FontAwesomeIcons.sortAlphaDown, 
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        filterUp ? widget.searchController.sortList((Recipe a, Recipe b) {
                          return b.name.compareTo(a.name);
                        }) : widget.searchController.sortList((Recipe a, Recipe b) {
                          return a.name.compareTo(b.name);
                        });  
                        setState(() {
                          filterUp = !filterUp;
                        });
                      },
                    ),
                    AutoSizeText(
                      'Sort',
                      style: TextStyle(color: Colors.grey),
                      maxLines: 1,
                      maxFontSize: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Divider(thickness: 1.0, indent: 5.0, endIndent: 5.0,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    Align cancelWidget = Align(
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
                  widget.searchController.clear();
                  FocusScope.of(context).unfocus();
                },
                icon: Icon(Icons.cancel))
            ),
        ),
      ),
    );

    Row emptyWidget = Row(
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
    );

    return SearchBar<Recipe>(
      searchBarStyle: SearchBarStyle(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        padding: EdgeInsets.only(left: 15.0),
      ),

      icon: Icon(Icons.search),
      hintText: 'Search recipes, cuisines, diets, ...',
      hintStyle: TextStyle(
        color: Colors.grey[400],
      ),
      shrinkWrap: true,
      headerPadding: EdgeInsets.all(5.0),
      searchBarPadding: EdgeInsets.only(left: 15.0, right: 15.0),
      searchBarController: widget.searchController,
      cancellationWidget: cancelWidget,
      onError: (Error error) { return Text(error.toString());},
      onCancelled: () {
        print('Cancel Search');
      },

      header: buildHeaderRow(),

      debounceDuration: Duration(milliseconds: 1500),
      emptyWidget: emptyWidget,

      minimumChars:2,
      onSearch: search, 
      onItemFound: (Recipe recipe, int index) {

        return Container(
          child: buildSearchRecipeResult(recipe)
        );
      },
    );
  }
}