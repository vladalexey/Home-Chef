import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/diet_model.dart';
import 'package:homechef/screens/diet_screen.dart';

class DietCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'By diet',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5
                ),
              ),
              GestureDetector(
                onTap: () => print('See all'),
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
          height: 210.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: diets.length,
            itemBuilder: (BuildContext context, int index) {
              Diet diet = diets[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DietPage(
                      diet: diet,
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: 200.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 80.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${diet.recipes.length} recipes',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                                  diet.description,
                                  style: TextStyle(
                                    color: Colors.grey,
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
                              tag: diet.imageUrl,
                              child: Stack(
                                children: <Widget>[ 
                                  Container(
                                    height: 120.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        height: 120.0,
                                        width: 190.0,
                                        image: AssetImage(diet.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                        
                                    Container(
                                      height: 120.0,
                                      width: 190.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.9),
                                          ],
                                          stops: [
                                            0.7,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    diet.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
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
      ],
    );
  }
}