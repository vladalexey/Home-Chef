import 'package:flutter/material.dart';
import 'package:homechef/models/diet_model.dart';

class DietPage extends StatefulWidget {

  final Diet diet;
  DietPage({this.diet});
  
  @override
  _DietPageState createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[

              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Hero(
                  tag: widget.diet.imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: AssetImage(widget.diet.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                      Colors.transparent,
                      Color(0xffFCD966),
                    ],
                    stops: [
                      0.0,
                      0.3,
                      0.5,
                      1.0
                    ])
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 70.0
                ),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,

                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          iconSize: 30.0,
                          color: Colors.white,
                          onPressed: () => Navigator.pop(context),
                        ), 
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.search),
                              iconSize: 30.0,
                              color: Colors.white,
                              onPressed: () => Navigator.pop(context),
                            ),
                            IconButton(
                              icon: Icon(Icons.sort),
                              iconSize: 30.0,
                              color: Colors.white,
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 
                      MediaQuery.of(context).size.width * 0.45
                    ),

                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, bottom: 10.0),
                          child: Text(
                            widget.diet.name,
                            style: TextStyle(
                              // shadows: Sha,
                              fontSize: 65.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1D1D1D),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}
