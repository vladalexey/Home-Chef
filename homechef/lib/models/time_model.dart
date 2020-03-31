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


final List<Recipe> recipes = [
  Recipe(
    id: '1',
    imageUrl: 'assets/imgs/food4.jpg',
    name: 'Sushi',
    description: 'Lorem ipsum dolor sit amet.',
    ingredients: [],
    instruction: []
  ),
  Recipe(
    id: '2',
    imageUrl: 'assets/imgs/food5.jpg',
    name: 'Yellow Curry',
    description: 'Lorem ipsum dolor sit amet.',
    ingredients: [],
    instruction: []
  ),
  Recipe(
    id: '3',
    imageUrl: 'assets/imgs/food6.jpg',
    name: 'Cheeseburger',
    description: 'Lorem ipsum dolor sit amet.',
    ingredients: [],
    instruction: []
  ),
];

final List<Time> times = [
  Time(
    imageUrl: 'assets/imgs/food11.jpg',
    name: '45 minutes',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
  ),
  Time(
    imageUrl: 'assets/imgs/food12.jpg',
    name: '30 minutes',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
  ),
  Time(
    imageUrl: 'assets/imgs/food13.jpg',
    name: '15 minutes',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
  ),
];