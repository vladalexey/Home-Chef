import 'package:flutter/material.dart';
import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/widgets/flappy_search_bar-1.7.2-modified/lib/flappy_search_bar.dart';
import 'package:homechef/widgets/flappy_search_bar-1.7.2-modified/lib/search_bar_style.dart';

class CuisineOption extends StatefulWidget {

  final Function() callSearchScreen;
  final SearchBarController<Recipe> searchController;
  CuisineOption({@required this.callSearchScreen,
    @required this.searchController});

  @override
  _CuisineOptionState createState() => _CuisineOptionState();
}

Future<List<String>> searchCuisine(String text) async {
  List<String> matchCuisine = [];

  for (String cuisine in cuisine_list) {

    if (cuisineOptions[encodeCuisineName(cuisine)]) {
      matchCuisine.insert(0, cuisine);
    } else if (text.length <= cuisine.length && cuisine.substring(0, text.length).toLowerCase() == text.toLowerCase()) {
      matchCuisine.add(cuisine);
    }
  }
  print('Match Cuisine Found: ' + matchCuisine.toString());
  return matchCuisine;
}

class _CuisineOptionState extends State<CuisineOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(

        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: EdgeInsets.all(15.0),

          child: Card(
            elevation: 3.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 0.0),
                            child: FlatButton(
                              onPressed: () {
                                widget.callSearchScreen();
                                widget.searchController.triggerSearch();
                              },
                              child: Icon(Icons.arrow_back_ios)
                              ),
                          )
                        ],
                      ),
                    ),
                    
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SearchBar<String>(
                          header: Column(
                            children: <Widget>[
                              Divider(indent: 15.0, endIndent: 15.0,),
                              Center(child: Text('Choose cuisines:')),
                              Divider(indent: 15.0,endIndent: 15.0,),
                            ],
                          ),
                          headerPadding: EdgeInsets.symmetric(horizontal: 5.0),

                          searchBarStyle: SearchBarStyle(
                            backgroundColor: Colors.white,
                          ),
                          searchBarPadding: EdgeInsets.symmetric(horizontal: 5.0),
                          onSearch: searchCuisine,
                          shrinkWrap: true,
                          minimumChars: 0,
                          hintText: 'Select cuisines by searching',
                          hintStyle: TextStyle(color: Colors.grey),
                          onItemFound: (String foundCuisine, int index) {
                            
                            return GestureDetector(

                              onTap: () {
                                foundCuisine = encodeCuisineName(foundCuisine);
                                print(cuisineOptions);
                                setState(() {
                                  cuisineOptions[foundCuisine] = !cuisineOptions[foundCuisine];
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(child: Text(foundCuisine)),
                                        Flexible(
                                          child: Checkbox(
                                            value: cuisineOptions[encodeCuisineName(foundCuisine)],
                                            onChanged: (value) {
                                              setState(() {
                                                cuisineOptions[encodeCuisineName(foundCuisine)] = value;
                                              });
                                            },
                                            ),
                                        )
                                      ],
                                    )),
                                ),
                              ),
                            );
                          },

                          onError: (Error error) { print(error.toString()); return Text(error.toString());},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}