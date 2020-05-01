import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {

  final int rating;
  final Color color;
  final Color borderColor;
  RatingStars({@required this.rating, @required this.color, @required this.borderColor});

  Row _buildRatingStars(int rating, Color color, Color borderColor) {

    Row stars = Row(
      children: <Widget>[
      for (int i = 0; i < 5; i++) (i < rating) 
        ? Icon(Icons.star, color: this.color, size: 16.0,)
        : Icon(Icons.star, color: this.borderColor, size: 16.0,)
    ],);


    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return _buildRatingStars(this.rating, this.color, this.borderColor);
  }
}

