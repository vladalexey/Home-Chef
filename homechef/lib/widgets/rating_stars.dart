import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {

  final int rating;
  RatingStars({@required this.rating});

  Text _buildRatingStars(int rating) {
    
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars, style: TextStyle(fontSize: 18.0),);
  }

  @override
  Widget build(BuildContext context) {
    return _buildRatingStars(this.rating);
  }
}

