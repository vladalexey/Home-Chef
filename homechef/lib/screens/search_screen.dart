import 'package:flutter/material.dart';
import 'package:homechef/widgets/search_widgets/diet_option.dart';
import 'package:homechef/widgets/search_widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  double heightCuisine = 0.0;
  double widthCuisine = 0.0;

  void toggleDietOptionfromSearchBar() {
    setState(() {
      if (widthCuisine == 200.0) {
        widthCuisine = 0.0;
        heightCuisine = 0.0;
      } else {
        widthCuisine = 200.0;
        heightCuisine = 200.0;
      }
    });
  }

  // void closeDietOptionfromDietOption() {
  //   setState(() {
  //     widthCuisine = 0.0;
  //     heightCuisine = 0.0;
  //   });
  // }

  // void getDietOption() {
    
  // }

  // Offset getWarningPos() {
  //   final RenderBox warningBox = dietOptionKey.currentContext.findRenderObject();
  //   final warningPos = warningBox.localToGlobal(Offset.zero);
  //   print(warningPos.dy);
  //   return warningPos;
  // }
  
  @override
  Widget build(BuildContext context) {

    double startPos, dis;

    return Scaffold(
      backgroundColor: Colors.amber,
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
            setState(() {
              heightCuisine = 0.0;
              widthCuisine = 0.0;
            });
          },
          onPanStart: (DragStartDetails details) {
            startPos = details.globalPosition.dx;
          },
          onPanUpdate: (DragUpdateDetails details) {
            dis = details.globalPosition.dx - startPos;
          },
          onPanEnd: (DragEndDetails details) {
            if (dis > 0) {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
              setState(() {
                heightCuisine = 0.0;
                widthCuisine = 0.0;
              });
            }
          },
          child: SafeArea(
            child: Stack(
              children: <Widget>[

                Center(
                  // SEARCH BAR
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(30.0)
                      ),
                      elevation: 5.0,
                      child: SearchBarWidget(callSearchScreen: toggleDietOptionfromSearchBar,)
                    ),
                  ),
                ),

                Positioned(
                  top: 200.0,
                  left: MediaQuery.of(context).size.width * 0.2,
                  child: AnimatedContainer(
                    width: widthCuisine,
                    duration: Duration(milliseconds: 200),
                    child: DietOption(callSearchScreen: toggleDietOptionfromSearchBar,),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}