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

class _CuisineOptionState extends State<CuisineOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: EdgeInsets.all(15.0),

        child: Card(
          elevation: 3.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton(
                        onPressed: () {
                          widget.callSearchScreen();
                        },
                        child: Text('Done', style: TextStyle(fontSize: 18.0, color: Colors.blue,),),
                        ),
                    )
                  ],
                ),
              ),
              
              Expanded(
                child: SearchBar<String>(
                  header: Column(
                    children: <Widget>[
                      Divider(color: Colors.amber, thickness: 2.0, indent: 15.0, endIndent: 15.0,),
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
            ],
          ),
        ),
      ),
    );
  }
}