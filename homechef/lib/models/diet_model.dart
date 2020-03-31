import 'package:homechef/models/recipe_model.dart';

class Diet {
  String imageUrl;
  String name;
  String description;
  List<Recipe> recipes;

  Diet({
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

final List<Diet> diets = [
  Diet(
    imageUrl: 'assets/imgs/food8.jpg',
    name: 'Vegan',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
    ),
  Diet(
    imageUrl: 'assets/imgs/food9.jpg',
    name: 'Keto',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
    ),
  Diet(
    imageUrl: 'assets/imgs/food10.jpg',
    name: 'Mediterrean',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
    ),
];