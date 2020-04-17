import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {

  final int rating;
  final Color color;
  RatingStars({@required this.rating, this.color});

  Row _buildRatingStars(int rating, Color color) {

    Row stars = Row(
      children: <Widget>[
      for (int i = 0; i < 5; i++) (i < rating) 
        ? Icon(Icons.star, color: this.color, size: 16.0,)
        : Icon(Icons.star_border, color: this.color, size: 16.0,)
    ],);


    return stars;
    
    // String stars = '';
    // for (int i = 0; i < rating; i++) {
    //   stars += '⭐ ';
    // }
    // stars.trim();
    // return Text(stars, style: TextStyle(fontSize: 18.0),);
  }

  @override
  Widget build(BuildContext context) {
    return _buildRatingStars(this.rating, this.color);
  }
}

