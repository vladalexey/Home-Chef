import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:homechef/models/cuisine_model.dart';

class CuisineOption extends StatefulWidget {

  final Function() callSearchScreen;
  CuisineOption({@required this.callSearchScreen});

  @override
  _CuisineOptionState createState() => _CuisineOptionState();
}

Future<List<String>> searchCuisine(String text) async {
  List<String> matchCuisine = [];

  for (String cuisine in cuisine_list) {

    if (text.length <= cuisine.length && cuisine.substring(0, text.length).toLowerCase() == text.toLowerCase()) {
      matchCuisine.add(cuisine);
    }
  }
  print('Match Cuisine Found: ' + matchCuisine.toString());
  return matchCuisine;
}

List<Widget> populateChosenCuisine() {



}

class _CuisineOptionState extends State<CuisineOption> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      width: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Card(
          elevation: 3.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          
          child: SearchBar<String>(
            header: Center(child: Text('Choose cuisines:')),
            headerPadding: EdgeInsets.all(5.0),

            searchBarStyle: SearchBarStyle(
              backgroundColor: Colors.white,
            ),
            searchBarPadding: EdgeInsets.all(5.0),
            onSearch: searchCuisine,
            minimumChars: 0,
            // cancellationWidget: Center(child: 
            //   IconButton(
            //     onPressed: () {
            //     },
            //     icon: Icon(Icons.cancel))
            // ),
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
    );
  }
}