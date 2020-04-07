import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/widgets/bounce_button.dart';

class DietOption extends StatefulWidget {

  final Function() callSearchScreen;
  DietOption({@required this.callSearchScreen});

  @override
  _DietOptionState createState() => _DietOptionState();
}

class _DietOptionState extends State<DietOption> with TickerProviderStateMixin {

  List<AnimationController> parentControllers;
  List<AnimatedButton> dietButtons;

  @override
  void initState() {
    super.initState();
    
    parentControllers = List<AnimationController>.generate(
      diets.length, (int index) {
        return new AnimationController(vsync: this, duration: Duration(milliseconds: 200)); 
      });
    
    dietButtons = getDietButtons(parentControllers);
  }

  Row populateDietCard(int index) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              child: dietButtons[index]

            ),
          ),
        ),
        
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              child: dietButtons[index + 1]
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: FittedBox(
        fit: BoxFit.contain,

        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,

          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            elevation: 20.0,

            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      
                      FlatButton(
                        onPressed: () {
                          widget.callSearchScreen();
                        },
                        child: Icon(Icons.arrow_back_ios)
                      ),
                      
                      Expanded(child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Choose a diet',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                          ),
                      ),),
                      
                    ],
                  ),

                  Divider(color: Colors.amber[300], thickness: 1.0,),

                  populateDietCard(0),
                  populateDietCard(2),
                  populateDietCard(4),
                  populateDietCard(6),
                  populateDietCard(8),

                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}