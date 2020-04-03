import 'package:flutter/material.dart';
import 'package:homechef/widgets/search_widgets/cuisine_option.dart';
import 'package:homechef/widgets/search_widgets/diet_option.dart';
import 'package:homechef/widgets/search_widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  double heightCuisine = 0.0;
  double widthCuisine = 0.0;

  double heightDiet = 0.0;
  double widthDiet = 0.0;

  void toggleDietOptionfromSearchBar() {

    MediaQuery.of(context).size.width;

    print('Toggle diet option');
    setState(() {
      
      if (widthDiet == MediaQuery.of(context).size.width * 0.8) {
        widthDiet = 0.0;
        heightDiet = 0.0;
      } else {
        widthDiet = MediaQuery.of(context).size.width * 0.8;
        heightDiet = 600.0;

        if (widthCuisine == 200.0) {
          widthCuisine = 0.0;
          heightCuisine = 0.0;
        }
      }
    });
  }

  void toggleCuisineOptionfromSearchBar() {
    print('Toggle cuisine option');
    setState(() {
      
      if (widthCuisine == 200.0) {
        widthCuisine = 0.0;
        heightCuisine = 0.0;
      } else {
        widthCuisine = 200.0;
        heightCuisine = 200.0;

        if (widthDiet == MediaQuery.of(context).size.width * 0.8) {
          widthDiet = 0.0;
          heightDiet = 0.0;
        }
        
      }
    });
  }

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

    return GestureDetector(
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

      onTap: () {
        setState(() {
          if (widthDiet == MediaQuery.of(context).size.width * 0.8) {
            widthDiet = 0.0;
            heightDiet = 0.0;
          }
          if (widthCuisine == 200.0) {
            widthCuisine = 0.0;
            heightCuisine = 0.0;
          }
        });
        
      },

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amber,
        body: SafeArea(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20.0,),
                  IconButton(
                    onPressed: () => Navigator.pop(context), 
                    icon: Icon(Icons.arrow_back_ios))
                ],
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
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
                              child: SearchBarWidget(
                                callSearchScreenDiet: toggleDietOptionfromSearchBar,
                                callSearchScreenCuisine: toggleCuisineOptionfromSearchBar,)
                            ),
                          ),
                        ),

                        Center(
                          child: AnimatedContainer(
                            width: widthDiet,
                            curve: Curves.bounceInOut,
                            duration: Duration(milliseconds: 200),
                            child: DietOption(callSearchScreen: toggleDietOptionfromSearchBar,),
                          ),
                        ),

                        Center(
                          child: AnimatedContainer(
                            width: widthCuisine,
                            curve: Curves.bounceInOut,
                            duration: Duration(milliseconds: 200),
                            child: CuisineOption(callSearchScreen: toggleCuisineOptionfromSearchBar,),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),

              
            ],
            ),
        ),
      ),
    );
  }
}