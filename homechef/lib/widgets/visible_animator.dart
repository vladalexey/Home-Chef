import 'package:flutter/material.dart';

class VisibleAnimator extends StatelessWidget {

  final bool show;
  VisibleAnimator({this.show});

  @override
  Widget build(BuildContext context) {

    double opacity = show ? 1.0 : 0.0;

    return AnimatedOpacity(
      duration: Duration(microseconds: 50),
      opacity: opacity,
      child: Center(
      // SEARCH BAR
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)
              ),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        spreadRadius: 3
              )]
          ),

          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Colors.blue,
            elevation: 20.0,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(30.0),

            child: TextField(
              autofocus: true,
              cursorColor: Colors.amber,
              style: TextStyle(height: 1.2),
              decoration: InputDecoration(
                
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xff383838),
                ),
                contentPadding: EdgeInsets.only(left: 50.0, top: 0.0, bottom: 0.0),
                hintText: 'Search recipes, cuisine, dish',
                hintMaxLines: 1,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(30.0),
                  ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}