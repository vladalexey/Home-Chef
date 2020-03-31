import 'package:homechef/models/ingredients/ingredient_model.dart';

class IngredientList {
  final List<Ingredient> ingredients;

  IngredientList({
    this.ingredients
  });

  factory IngredientList.fromJson(Map<String, dynamic> ingredientResult) {

    List<Ingredient> ingredients = [];

    List<Map> ingredient_objs = new List<Map>.from(ingredientResult['ingredients']);
    for (Map<String, dynamic> ingredient_obj in ingredient_objs) {

      Ingredient ingredient = new Ingredient(
        id: ingredient_obj['id'],
        name: ingredient_obj['name']
      );

      ingredients.add(ingredient);
      
    }

    return IngredientList(ingredients: ingredients);  
  }
}