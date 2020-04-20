import 'package:homechef/models/diet_model.dart';
import 'package:homechef/models/recipe_model.dart';

class Time {
  String imageUrl;
  String name;
  String description;
  List<Recipe> recipes;

  Time({
    this.imageUrl,
    this.name,
    this.description,
    this.recipes,
  });
}

Map<String, bool> timesOptions = {
  "Under 180 minutes": false,
  "Under 120 minutes": false,
  "Under 90 minutes": false,
  "Under 60 minutes": false,
  "Under 30 minutes": false,
  "Under 15 minutes": false,
};

String getMinutes(String timeOption) {
  print(timeOption.split(' '));
  return (timeOption.split(' ')[1]);
}

List<Time> times = new List<Time>.generate(timesOptions.keys.length, (int index) {
  return new Time(
    imageUrl: 'assets/imgs/' + getMinutes(timesOptions.keys.toList()[index]) + '.jpg',
    name: timesOptions.keys.toList()[index],
    description: timesOptions.keys.toList()[index],
    recipes: recipes
  );
});


// final List<Time> times = [
//   Time(
//     imageUrl: 'assets/imgs/45min.jpg',
//     name: '45 minutes',
//     description: 'Lorem ipsum dolor sit amet.',
//     recipes: recipes,
//   ),
//   Time(
//     imageUrl: 'assets/imgs/30min.jpg',
//     name: '30 minutes',
//     description: 'Lorem ipsum dolor sit amet.',
//     recipes: recipes,
//   ),
//   Time(
//     imageUrl: 'assets/imgs/15min.jpg',
//     name: '15 minutes',
//     description: 'Lorem ipsum dolor sit amet.',
//     recipes: recipes,
//   ),
// ];