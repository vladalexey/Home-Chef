import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/models/search_result_model.dart';
import 'package:homechef/screens/recipe.dart';

class CuisinePage extends StatefulWidget {

  final Cuisine cuisine;
  CuisinePage({this.cuisine});
  
  @override
  _CuisinePageState createState() => _CuisinePageState();
}

class _CuisinePageState extends State<CuisinePage> {

  final SearchBarController<Recipe> searchController = SearchBarController();
  double _searchContainerHeight = 0.0;


  Future<List<Recipe>> search(String text) async {

    List<Recipe> foundResult = [];

    await Future.delayed(Duration(seconds: 1));
    for (Recipe recipe in searchResults) {
      if (recipe.name.contains(text)) {
        foundResult.add(recipe);
      }
    }

    return foundResult;
  }

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  Widget topPart() {
    return Stack(
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
            tag: widget.cuisine.imageUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image(
                image: AssetImage(widget.cuisine.imageUrl),
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
                Colors.yellow[600],
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
            top: 70.0
          ),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,

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
                            onPressed: () {
                              _searchContainerHeight = MediaQuery.of(context).size.height;
                              setState(() {
                                
                              });
                            },
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


                  // Visibility(
                  //     visible: _visible,
                  //     child: Center(
                  //     // SEARCH BAR
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.only(
                  //           bottomLeft: Radius.circular(30.0),
                  //           bottomRight: Radius.circular(30.0)
                  //           ),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.black54,
                  //                     offset: Offset(0, 10),
                  //                     blurRadius: 20,
                  //                     spreadRadius: 3
                  //           )]
                  //       ),

                  //       width: MediaQuery.of(context).size.width,
                  //       child: Material(
                  //         color: Colors.blue,
                  //         elevation: 20.0,
                  //         shadowColor: Colors.black,
                  //         borderRadius: BorderRadius.circular(30.0),

                  //         child: TextField(
                  //           autofocus: true,
                  //           cursorColor: Colors.amber,
                  //           style: TextStyle(height: 1.2),
                  //           decoration: InputDecoration(
                              
                  //             prefixIcon: Icon(
                  //               Icons.search,
                  //               color: Color(0xff383838),
                  //             ),
                  //             contentPadding: EdgeInsets.only(left: 50.0, top: 0.0, bottom: 0.0),
                  //             hintText: 'Search recipes, cuisine, dish',
                  //             hintMaxLines: 1,
                  //             border: OutlineInputBorder(
                  //               borderSide: BorderSide(color: Colors.transparent),
                  //               borderRadius: BorderRadius.circular(30.0),
                  //               ),
                  //             filled: true,
                  //             fillColor: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

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
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 0.0),
                    child: Text(
                      widget.cuisine.name,
                      style: TextStyle(
                        // shadows: Sha,
                        fontSize: 65.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget categoriesListBuilder() {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
          itemCount: widget.cuisine.recipes.length,
          itemBuilder: (BuildContext context, int index) {
            Recipe recipe = widget.cuisine.recipes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipePage(
                      recipe: recipe,
                    )
                  ));
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
                              Column(
                                children: <Widget>[
                                  Text(
                                    '${recipe.id}',
                                    style: TextStyle(
                                      fontSize: 22.0,
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
                      child: Image(
                        width: 110.0,
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

  Widget buildSearchBar() {

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: _searchContainerHeight,
      child: GestureDetector(
        onTap: () {
          searchController.clear();
          FocusScope.of(context).unfocus();
          // _iconHeight = 80.0;
          _searchContainerHeight = 0.0;
          setState(() {
            
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
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
            height: MediaQuery.of(context).size.height,
            
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
                              _searchContainerHeight = 0.0;
                              setState(() {
                                
                              });
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
                emptyWidget: Text('No results found'),

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
    );
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
            // height: 170.0,
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
                      Column(
                        children: <Widget>[
                          Text(
                            '${recipe.id}',
                            style: TextStyle(
                              fontSize: 22.0,
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
              child: Image(
                width: 110.0,
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
        body: Stack(
          children: <Widget> [Column(
            children: <Widget>[

              topPart(),
              categoriesListBuilder()
              
              ],
            ),

            buildSearchBar(),
          ]
        )
      ),
    );
  }
}
