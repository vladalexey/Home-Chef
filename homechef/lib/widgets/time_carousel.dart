import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/models/time_model.dart';
import 'package:homechef/screens/cuisine_screen.dart';
import 'package:homechef/screens/time_screen.dart';

class TimeCarousel extends StatelessWidget {
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
                'By cooking time',
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
          height: 215.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            itemBuilder: (BuildContext context, int index) {
              Time time = times[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TimePage(
                      time: time,
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
                          width: 160.0,
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
                                  '${time.recipes.length} recipes',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                                  time.description,
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
                              tag: time.imageUrl,
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
                                        width: 160.0,
                                        image: AssetImage(time.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                        
                                    Container(
                                      height: 120.0,
                                      width: 160.0,
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
                                    time.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
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