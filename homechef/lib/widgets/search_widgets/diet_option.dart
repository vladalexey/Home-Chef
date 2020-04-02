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
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          children: <Widget>[
                            Text('Vegan', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['veganBool'],
                              onChanged: (bool value) {
                                setState(() {
                                  dietOptions['veganBool'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    

                    
                    Expanded(
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Vegetarian', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['vegetarianBool'],
                              onChanged: (bool value) {
                                setState(() {
                                  dietOptions['vegetarianBool']= value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                    
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text('Lacto Vegetarian', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['lactoVegetarianBool'],
                              onChanged: (bool value) {
                                setState(() {
                                  dietOptions['lactoVegetarianBool'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          children: <Widget>[
                            Text('Ovo Vegetarian', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['ovoVegetarianBool'],
                              onChanged: (bool value) {
                                setState(() {
                                  dietOptions['ovoVegetarianBool'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),


                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          children: <Widget>[
                            Text('Keto', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['ketoBool'],
                              onChanged: (bool value) {
                                setState(() {
                                  dietOptions['ketoBool'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          children: <Widget>[
                            Text('Whole30', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['whole30Bool'],
                              onChanged: (bool value) {
                                setState(() {
                                  dietOptions['whole30Bool'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          children: <Widget>[
                            Text('Gluten Free', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['glutenFreeBool'],
                              onChanged: (bool value) {
                                dietOptions['glutenFreeBool'] = value;
                                setState(() {
                                  
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          children: <Widget>[
                            Text('Paleo', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['paleoBool'],
                              onChanged: (bool value) {
                                dietOptions['paleoBool'] = value;
                                setState(() {
                                  
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )


                  ],
                ),


                
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          children: <Widget>[
                            Text('Primal', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['primalBool'],
                              onChanged: (bool value) {
                                setState(() {
                                  dietOptions['primalBool'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Card(
                        elevation: 1.0,
                        child: Column(
                          children: <Widget>[
                            Text('Pescetarian', style: TextStyle(fontSize: 20.0),),
                            Checkbox(
                              value: dietOptions['pescetarianBool'],
                              onChanged: (bool value) {
                                setState(() {
                                  dietOptions['pescetarianBool'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Divider(color: Colors.black54,),
                    SizedBox(height: 20.0),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0
                          ),
                        ),
                        onPressed: () {
                          widget.callSearchScreen();
                        },
                      ),
                    ),
                  ],
                )
              ],

            ),
          ),
        ),
      ),
    );
  }
}