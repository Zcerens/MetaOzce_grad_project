import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  double userRating;
  IconData selectedIcon;
  bool isVertical;
  /*: _userRating = this.userRating,
        _selectedIcon = selectedIcon,
        _isVertical = isVertical,
        super(key: key);*/
  Rating(this.userRating, this.selectedIcon, this.isVertical);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: userRating,
      itemBuilder: (context, index) => Icon(
        selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 15.0,
      unratedColor: Colors.amber.withAlpha(50),
      direction: isVertical ? Axis.vertical : Axis.horizontal,
    );
  }
}