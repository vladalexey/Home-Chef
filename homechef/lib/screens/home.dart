import 'dart:math';
import 'dart:ui';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:homechef/screens/profile/profile.dart';
import 'package:homechef/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/widgets/carousels/cuisine_carousel.dart';
import 'package:homechef/widgets/carousels/diet_carousel.dart';
import 'package:homechef/widgets/carousels/popular_carousel.dart';
import 'package:homechef/widgets/carousels/time_carousel.dart';
import 'package:homechef/widgets/coming_feature.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> suggestionList = ['Vietnamese', 'Top 10', 'New Vegan Recipes', 'Discovery', 'Explore Europe', 'Grandma Style', 'Best Cookies'];
  List<Color> suggestionListColors = [Colors.amber[300], Colors.amber, Colors.yellow[700], Colors.orange, Colors.deepOrange[300]];

  Widget buildGradientTopCarousel() {
    return Padding(
      padding: EdgeInsets.only(
        left: 2.0,
        right: 20.0,
        top: 25.0,
        bottom: 5.0
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,

        children: <Widget>[

          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  'Most Trending',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 10.0,
                      ),
                    ],
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    // letterSpacing: -0.5,
                  ),
                ),
              )
            ],
          ),

          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 2.0, bottom: 12.0),
                child: Text(
                  'Don\'t miss out on the latest recipes',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 10.0,
                      ),
                    ],
                    fontSize: 12.0,
                    // fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    // letterSpacing: -0.5,
                  ),
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Divider(
                  height: 1.0,
                  // color: Colors.yellow[500],
                  thickness: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget introPart() {
    return Container(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 20.0, top: 30.0, bottom: 20.0),
        title: Text(
          'What would you like to make?',
          style: TextStyle( 
            fontSize: 30.0,
            fontWeight: FontWeight.bold
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ClipOval(
            child: Container(
              color: Colors.grey[200],
              height: 50.0,
              width: 50.0,
              child: FittedBox(
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    // size: 22.0,
                  ),
                  onPressed: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => SearchScreen())),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget suggestionsBuilder() {
    return Container(
      color: Colors.white,
      height: 40.0,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Scrollbar(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              
              Random randomInt = Random();

              return GestureDetector(
                onTap: () => WarningComingFeature(),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: suggestionListColors[randomInt.nextInt(suggestionListColors.length)],
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          suggestionList[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          ),)),
                    ),
                    ),
                ),
              );
            } 
          ),
        ),
      ),
    );
  }

  SafeArea homeScreen() {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Container(color: Colors.grey[50],)
          ),
          Scrollbar(
            child: ListView(
              children: <Widget>[

                introPart(),

                suggestionsBuilder(), 

                Container(
                  color: Colors.white,
                  child: buildGradientTopCarousel()),

                Container(
                  color: Colors.white,
                  child: PopularCarouselPage()),
                Divider(height: 0.5,),

                SizedBox(height: 10.0,),

                CuisineCarousel(),
                SizedBox(height: 5.0),
                
                Divider(indent: 8.0, endIndent: 8.0,),
                DietCarousel(),
                SizedBox(height: 5.0),
                
                Divider(indent: 8.0, endIndent: 8.0,),
                TimeCarousel(),
                
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // Image appTitle = Image.asset(
    //   'assets/imgs/appLogo9.png',
    //   fit: BoxFit.contain,
    //   height: 80.0,
    // );

    return DefaultTabController (

      length:3,
      child: new Scaffold(

        // appBar: AppBar(
        //   automaticallyImplyLeading: false, 
        //   titleSpacing: 0.0,
        //   elevation: 0.0,
        //   backgroundColor: Colors.white,
        //   title: appTitle,
        //   actions: <Widget>[

        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        //       child: Center(
        //         child: ClipOval(
        //           child: Container(
        //             height: 40.0,
        //             width: 40.0,
        //             color: Colors.grey[200],
        //             child: IconButton(
        //               onPressed: () => Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (_) => SearchScreen())
        //               ),
        //               icon: Icon(Icons.search),
        //               iconSize: 20.0,
        //               color: Colors.black87
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),

        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        //       child: Center(
        //         child: ClipOval(
        //           child: Container(
        //             height: 40.0,
        //             width: 40.0,
        //             color: Colors.grey[200],
        //             child: Center(
        //               child: IconButton(
        //                 onPressed: () {},
        //                 icon: Icon(Ionicons.ios_log_out),
        //                 iconSize: 20.0,
        //                 color: Colors.black87
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),

        //   ],

        // ),

        body: TabBarView(
          children: <Widget>[

            homeScreen(),

            ProfileScreen(),
            
            new Container(
              color: Colors.orange,
            ),
          ],
        ),

        bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: Image.asset('assets/imgs/appLogoOnly.png', height: 20.0,),
              ),
              Tab(
                icon: new Icon(Icons.person),
              ),
              Tab(icon: new Icon(Icons.favorite),)
            ],

            labelColor: Colors.amber[700],
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.amber[300],
          ),
          backgroundColor: Colors.white,
      ),
    ); 
  }
}
