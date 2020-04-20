import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/models/nutrients/nutrients_list_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/screens/recipe_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:homechef/widgets/rating_stars.dart';
import 'package:http/http.dart' as http;

import '../flappy_search_bar-1.7.2-modified/lib/flappy_search_bar.dart';
import '../flappy_search_bar-1.7.2-modified/lib/search_bar_style.dart';

class SearchBarWidget extends StatefulWidget {

  final SearchBarController<Recipe> searchController;
  SearchBarWidget({
    @required this.searchController});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> with TickerProviderStateMixin{

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
  
  bool filterUp = false;
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }
  
  Future<List<Recipe>> search(String text) async {

    String _diet = '';
    String _cuisine = '';
    String _time = '';

    String apiKey = await getFileData('assets/API_KEY.txt');
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

    for (String key in cuisine_list.keys) {
      if (cuisine_list[key] == true) {
        _cuisine = _cuisine + key + ',';
      }
    }

    _cuisine = _cuisine.substring(0, _cuisine.length - 1);
    

    // if (time != null) {
    //   _time = '&time=' + time.name;
    // }

    // Get list recipe IDs with search text

    String baseURL = 'https://api.spoonacular.com';
    // String baseURL = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';

    String searchURL = baseURL + '/recipes/complexSearch?query=' + text + 
      _cuisine + _diet + _time +
      "addRecipeInformation=true&addRecipeNutrition=true" +
      '&number=1&apiKey=' + apiKey;

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
          imageUrl: obj['image'] ,
          name: obj['title'],
          cookTime: obj['readyInMinutes'],
          servings: obj['servings'],
        );

        newRecipe.ingredients = getIngredientsOffline(obj['nutrition']);
        newRecipe.instruction = getInstructionsOffline(obj['analyzedInstructions']);
        
        newRecipe.calories = NutrientList.fromJson(obj['nutrition']).getCalories();
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
            margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            height: 170.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(0.0, 2.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(130.0, 0.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        
                        SizedBox(height: 20.0),
                        AutoSizeText(
                          recipe.name,
                          maxFontSize: 20.0,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          recipe.cookTime.toString() + ' minutes',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 10.0),
                  RatingStars(rating: recipe.rate),
                  // SizedBox(height: 10.0),
                ],
              ),
            ),
          ),

          Positioned(
            left: 30.0,
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
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 7.0)
            )
          ]
        ),
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
              child: FlatButton.icon(
                disabledTextColor: Colors.grey[700],
                onPressed: null, icon: Icon(Icons.filter_list), label: Text("Custom"),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
              child: FlatButton.icon(
                disabledTextColor: Colors.grey[700],
                onPressed: null, icon: Icon(Icons.person_outline), label: Text("Profile"),),
            ),
          ],
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.red[400], width: 2.0),
            insets: EdgeInsets.symmetric(horizontal: 70.0)),
          labelColor: Colors.grey[800],
          unselectedLabelColor: Colors.grey[600],
        ),
      );
    }

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
                  // widget.searchController.clear();
                  // FocusScope.of(context).unfocus();
                },
                icon: Icon(Icons.cancel))
            ),
        ),
      ),
    );
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

      // headerPadding: EdgeInsets.all(5.0),
      searchBarPadding: EdgeInsets.only(left: 20.0, right: 20.0),
      searchBarController: widget.searchController,
      
      header: buildHeaderRow(),

      cancellationWidget: cancelWidget,
      onError: (Error error) { return Text(error.toString());},
      onCancelled: () {
        print('Cancel Search');
      },

      debounceDuration: Duration(milliseconds: 1500),
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