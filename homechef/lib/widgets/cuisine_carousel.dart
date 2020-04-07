import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/screens/all_categories/all_cuisine_screen.dart';
import 'package:homechef/screens/cuisine_screen.dart';

class CuisineCarousel extends StatelessWidget {

  final List<Cuisine> shuffled = cuisines.toList()..shuffle();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'By cuisine',
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black12,
                      offset: Offset(1.0, 2.0),
                      blurRadius: 10.0,
                    ),
                  ],
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AllCuisinePage(
                      cuisines: cuisines,
                    ),
                  ),
                ),
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 280.0,
          child: Scrollbar(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // itemCount: cuisines.length,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                
                Cuisine cuisine = shuffled[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CuisinePage(
                        cuisine: cuisine,
                      ),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    width: 160.0,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          bottom: 5.0,
                          child: Container(
                            height: 80.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                  spreadRadius: 1
                                )
                              ],
                              // color: Colors.white,
                              // color: Color(0xffFFEF31),
                              color: Colors.amber[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${cuisine.recipes.length} recipes',
                                    style: TextStyle(
                                      shadows: [
                                        Shadow(
                                          color: Colors.black26,
                                          offset: Offset(1.0, 2.0),
                                          blurRadius: 10.0,
                                        ),
                                      ],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    cuisine.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: <Widget>[
                              Hero(
                                tag: cuisine.imageUrl,
                                child: Stack(
                                  children: <Widget>[ 
                                    Container(
                                      height: 180.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: Image(
                                          height: 180.0,
                                          width: 140.0,
                                          image: AssetImage(cuisine.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                          
                                      Container(
                                        height: 180.0,
                                        width: 140.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          gradient: LinearGradient(
                                            begin: FractionalOffset.topCenter,
                                            end: FractionalOffset.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black,
                                            ],
                                            stops: [
                                              0.5,
                                              1.0
                                            ])
                                        ),
                                      ),
                                  ]
                                ),
                              ),

                              Positioned(
                                left: 10.0,
                                bottom: 10.0,
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: SizedBox(
                                            width: 80.0,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Divider(
                                                height: 2.0,
                                                color: Colors.yellow,
                                                thickness: 2.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Flexible(
                                        child: FittedBox(
                                          child: AutoSizeText(
                                            cuisine.name,
                                            maxLines: 2,
                                            maxFontSize: 18.0,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing:  1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}