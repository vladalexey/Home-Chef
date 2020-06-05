import 'package:homechef/models/diet_model.dart';
import 'package:homechef/models/recipe_model.dart';

class Cuisine {
  String imageUrl;
  String name;
  String description;
  List<Recipe> recipes;

  Cuisine({
    this.imageUrl,
    this.name,
    this.description,
    this.recipes,
  });
}

Map<String, bool> cuisinesOptionsCopy;

Map<String, List<Recipe>> resultRecipes = {
  'African': recipes,
  'American': recipes,
  'British': recipes,
  'Cajun': recipes,
  'Caribbean': recipes,
  'Chinese': recipes,
  'Eastern European': recipes,
  'European': recipes,
  'French': recipes,
  'German': recipes,
  'Greek': recipes,
  'Indian': recipes,
  'Irish': recipes,
  'Italian': recipes,
  'Japanese': recipes,
  'Jewish': recipes,
  'Korean': recipes,
  'Latin American': recipes,
  'Mediterranean': recipes,
  'Mexican': recipes,
  'Middle Eastern': recipes,
  'Nordic': recipes,
  'Southern': recipes,
  'Spanish': recipes,
  'Thai': recipes,
  'Vietnamese': recipes,
};

Map<String, bool> cuisine_list = {
  'African': false,
  'American': false,
  'British': false,
  'Cajun': false,
  'Caribbean': false,
  'Chinese': false,
  'Eastern European': false,
  'European': false,
  'French': false,
  'German': false,
  'Greek': false,
  'Indian': false,
  'Irish': false,
  'Italian': false,
  'Japanese': false,
  'Jewish': false,
  'Korean': false,
  'Latin American': false,
  'Mediterranean': false,
  'Mexican': false,
  'Middle Eastern': false,
  'Nordic': false,
  'Southern': false,
  'Spanish': false,
  'Thai': false,
  'Vietnamese': false,
};

Map<String, List<String>> cuisineGroups = {
  "African": african,
  "Asian": asian,
  "America": america,
  "Europe": europe,
  "Middle Eastern": middle_eastern
};

List<String> african = ['African'];

List<String> asian = [
  'Chinese',
  'Indian',
  'Japanese',
  'Korean',
  'Thai',
  'Vietnamese',
];

List<String> america = [
  'American',
  'Cajun',
  'Caribbean',
  'Latin American',
  'Mexican',
  'Southern',
];

List<String> europe = [
  'British',
  'European',
  'Eastern European',
  'French',
  'German',
  'Greek',
  'Indian',
  'Irish',
  'Italian',
  'Mediterranean',
  'Nordic',
  'Spanish'
];

List<String> middle_eastern = [
  'Jewish',
  'Middle Eastern',
];

void getCuisinesCopy() {
  cuisinesOptionsCopy = new Map<String, bool>.of(cuisine_list);
}

String encodeCuisineName(String toEncode) {
  return toEncode.replaceAll(' ', '').toLowerCase();
}

Map<String, bool> cuisineOptions = Map.fromIterable(cuisine_list.keys,
    key: (cuisine) => encodeCuisineName(cuisine), value: (_) => false);

List<Cuisine> cuisines =
    new List<Cuisine>.generate(cuisine_list.keys.length, (int index) {
  return new Cuisine(
      imageUrl: 'assets/imgs/' +
          encodeCuisineName(cuisine_list.keys.toList()[index]) +
          '.jpg',
      name: cuisine_list.keys.toList()[index],
      description: 'Lorem ipsum dolor sit amet.',
      recipes: recipes);
});
