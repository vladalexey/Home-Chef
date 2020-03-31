import 'package:homechef/models/recipe_components/recipe_component.dart';

class RecipeComponentList {
  final List<RecipeComponent> recipeComponent;

  RecipeComponentList({
    this.recipeComponent
  });

  factory RecipeComponentList.fromJson(List<dynamic> json) {
    
    List<RecipeComponent> recipeComponents = json.map((element) => RecipeComponent.fromJson(element)).toList();

    return new RecipeComponentList(
      recipeComponent: recipeComponents
    );
  }
}