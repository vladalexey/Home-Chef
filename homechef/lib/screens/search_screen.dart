import 'package:flutter/material.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/widgets/search_widgets/cuisine_option.dart';
import 'package:homechef/widgets/search_widgets/diet_option.dart';
import 'package:homechef/widgets/search_widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin{

  AnimationController expandController, expandControllerDiet;
  Animation<double> animation, animationDiet;

  bool dietOpen = false, cuisineOpen = false;

  @override
  void initState() {
    super.initState();
    prepareAnimation();

  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  void prepareAnimation() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    );

    expandControllerDiet = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    );

    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.bounceInOut,
    );

    animationDiet = CurvedAnimation(
      parent: expandControllerDiet,
      curve: Curves.bounceInOut,
    );

  }

  void toggleDietOptionfromSearchBar() {

    MediaQuery.of(context).size.width;

    print('Toggle diet option');
    setState(() {

      FocusScope.of(context).unfocus();

      if (dietOpen) {
        expandControllerDiet.reverse();
      } else {
        if (cuisineOpen) {
          cuisineOpen = !cuisineOpen;
          expandController.reverse();
        }
        expandControllerDiet.forward();
      }

      dietOpen = !dietOpen;

    });
  }

  void toggleCuisineOptionfromSearchBar() {
    print('Toggle cuisine option');

    setState(() {

      FocusScope.of(context).unfocus();

      if (cuisineOpen) {
        expandController.reverse();
      } else {
        if (dietOpen) {
          dietOpen = !dietOpen;
          expandControllerDiet.reverse();
        }
        expandController.forward();
      }

      cuisineOpen = !cuisineOpen;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    double startPos, dis;

    DietOption dietOption = DietOption(callSearchScreen: toggleDietOptionfromSearchBar,);
    CuisineOption cuisineOption = CuisineOption(callSearchScreen: toggleCuisineOptionfromSearchBar,);

    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        startPos = details.globalPosition.dx;
      },
      onPanUpdate: (DragUpdateDetails details) {
        dis = details.globalPosition.dx - startPos;
      },
      onPanEnd: (DragEndDetails details) {
        if (dis > MediaQuery.of(context).size.width * 0.1) {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          expandController.reverse();
          expandControllerDiet.reverse();
        }
      },

      onTap: () {
        FocusScope.of(context).unfocus();
        if (dietOpen) {
          dietOpen = !dietOpen;
          expandControllerDiet.reverse();
        }

        if (cuisineOpen) {
          cuisineOpen = !cuisineOpen;
          expandController.reverse();
        }
        
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
                          child: ScaleTransition(
                            scale: animationDiet,
                            child: dietOption,
                          ),
                        ),

                        Center(
                          child: ScaleTransition(
                            scale: animation,
                            child: cuisineOption,
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