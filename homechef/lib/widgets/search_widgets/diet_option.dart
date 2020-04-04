import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:homechef/models/diet_model.dart';

class DietOption extends StatefulWidget {

  final Function() callSearchScreen;
  DietOption({@required this.callSearchScreen});

  @override
  _DietOptionState createState() => _DietOptionState();
}

class _DietOptionState extends State<DietOption> {

  Row populateDietCard(Diet diet, Diet diet2) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
                
                
                if (dietOptions[encodeDietName(diet.name)] == false) {
                  setAllFalse();
                }

                dietOptions[encodeDietName(diet.name)] = !dietOptions[encodeDietName(diet.name)];
                setState(() {
                  
                });
                // widget.callSearchScreen();
            },
            child: Card(
              color: dietOptions[encodeDietName(diet.name)] ? Colors.blue[300] : Colors.white,
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: AutoSizeText(diet.name, maxLines: 1, style: TextStyle(fontSize: 20.0),)),
              ),
            ),
          ),
        ),
        

        
        Expanded(
          child: GestureDetector(
            onTap: () {

                if (dietOptions[encodeDietName(diet2.name)] == false) {
                  setAllFalse();
                }
                dietOptions[encodeDietName(diet2.name)] = !dietOptions[encodeDietName(diet2.name)];
                setState(() {
                  
                });

            },
            child: Card(
              color: dietOptions[encodeDietName(diet2.name)] ? Colors.blue[300] : Colors.white,
              elevation: 1.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AutoSizeText(diet2.name, maxLines: 1, style: TextStyle(fontSize: 20.0),),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Choose a diet',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300),
                        ),
                    ),),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      // color: Colors.blue,
                      onPressed: () {
                        widget.callSearchScreen();
                      },)
                  ],
                ),

                Divider(color: Colors.yellow,thickness: 2.0,),

                populateDietCard(diets[0], diets[1]),
                populateDietCard(diets[2], diets[3]),
                populateDietCard(diets[4], diets[5]),
                populateDietCard(diets[6], diets[7]),
                populateDietCard(diets[8], diets[9]),

              ],

            ),
          ),
        ),
      ),
    );
  }
}