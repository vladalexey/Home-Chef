import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homechef/models/time_model.dart';
import 'package:homechef/screens/all_categories/all_time_screen.dart';
import 'package:homechef/screens/time_screen.dart';
import 'package:homechef/widgets/size_route.dart';

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
                    builder: (_) => AllTimePage(
                      times: times,
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
          height: 220.0,
          child: Scrollbar(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: times.length,
              itemBuilder: (BuildContext context, int index) {
                Time time = times[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    SizeRoute(
                      page: TimePage(
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                  spreadRadius: 1
                                )
                              ],
                              // color: Colors.white,
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${time.recipes.length} recipes',
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
                                    time.description,
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
                                tag:time.imageUrl,
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
                                          width: 140.0,
                                          image: AssetImage(time.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                          
                                      Container(
                                        height: 120.0,
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
                                              0.6,
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

                                    Row(
                                      children: <Widget>[
                                        Padding(
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
                                        )
                                      ],
                                    ),
                                    
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
        ),
      ],
    );
  }
}