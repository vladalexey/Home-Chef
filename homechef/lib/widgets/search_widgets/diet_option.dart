import 'package:flutter/material.dart';
import 'package:homechef/models/diet_model.dart';

class DietOption extends StatefulWidget {

  final Function() callSearchScreen;
  DietOption({@required this.callSearchScreen});

  @override
  _DietOptionState createState() => _DietOptionState();
}

class _DietOptionState extends State<DietOption> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,

      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,

        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 5.0,

          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['veganBool'] = ! dietOptions['veganBool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Vegan', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),
                    

                    
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['vegetarianBool'] = ! dietOptions['vegetarianBool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Vegetarian', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                    
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['lactoVegetarianBool'] = ! dietOptions['lactoVegetarianBool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Lacto Vegetarian', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['ovoVegetarianBool'] = ! dietOptions['ovoVegetarianBool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Ovo Vegetarian', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),


                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['ketoBool'] = ! dietOptions['ketoBool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Keto', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['whole30Bool'] = ! dietOptions['whole30Bool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Whole30', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['glutenFreeBool'] = ! dietOptions['glutenFreeBool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Gluten Free', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['paleoBool'] = ! dietOptions['paleoBool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Paleo', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    )


                  ],
                ),


                
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['primalBool'] = ! dietOptions['primalBool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Primal', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                           dietOptions['pescetarianBool'] = ! dietOptions['pescetarianBool'];
                           Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Pescetarian', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}