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

Map<String, bool> timeOptionsCopy;

void getTimesCopy() {
  timeOptionsCopy = new Map<String, bool>.of(timesOptions);
}

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
