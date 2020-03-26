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


final List<Recipe> recipes = [
  Recipe(
    id: '1',
    imageUrl: 'assets/imgs/food4.jpg',
    name: 'Sushi',
    description: 'Lorem ipsum dolor sit amet.',
    ingredients: ['Green Scallion', 'Carrot', 'Brocolli', 'Chicken Breast'],
  ),
  Recipe(
    id: '2',
    imageUrl: 'assets/imgs/food5.jpg',
    name: 'Yellow Curry',
    description: 'Lorem ipsum dolor sit amet.',
    ingredients: ['Teriyaki', 'Onion', 'Beef'],
  ),
  Recipe(
    id: '3',
    imageUrl: 'assets/imgs/food6.jpg',
    name: 'Cheeseburger',
    description: 'Lorem ipsum dolor sit amet.',
    ingredients: ['Onion', 'Ginger', 'Soy Sauce'],
  ),
];

final List<Cuisine> cuisines = [
  Cuisine(
    imageUrl: 'assets/imgs/food1.jpg',
    name: 'Indian',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
  ),
  Cuisine(
    imageUrl: 'assets/imgs/food2.jpg',
    name: 'Japanese',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
  ),
  Cuisine(
    imageUrl: 'assets/imgs/food3.jpg',
    name: 'Fast Food',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
  ),
];