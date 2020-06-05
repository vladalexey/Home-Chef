import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:homechef/models/cuisine_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:ultimate_data_generator/ultimate_data_generator.dart';
import 'package:http/http.dart' as http;

Future<List<Recipe>> getCuisineCategoryRecipes(int numberRecipes, String cuisineName) async {

  List<Recipe> cuisineRecipes = List<Recipe>();
  String apiKey = await getFileData('assets/API_KEY.txt');
  print(apiKey);
  Map<String, String> _headers;

  Random random = new Random();

  String baseURL = 'https://api.spoonacular.com';
  // String baseURL = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';

  while (cuisineRecipes.length < numberRecipes) {

    List<String> generateFood = [
      FoodGen.generateNonVegetarianMainMealFoodName(),
      FoodGen.generateNonVegetarianSnacksFoodName(),
      FoodGen.generateNonVegetarianStarterFoodName(),
      FoodGen.generateVeganMainMealFoodName(),
      FoodGen.generateVeganSnacksFoodName(),
      FoodGen.generateVegetarianSnacksFoodName()
    ];

    int indexRandomFood = random.nextInt(generateFood.length);
    String chosenFoodName = generateFood[indexRandomFood]
            .split(' ')[
        generateFood[indexRandomFood].split(' ').length -
            1];
    String offset = random.nextInt(20).toString();

    String searchURL = baseURL +
        '/recipes/complexSearch?' +
        'query=' +
        chosenFoodName +
        '&cuisine=' + encodeCuisineName(cuisineName) +
        '&sort=popularity' +
        '&sortDirection=desc' +
        "&addRecipeInformation=true&addRecipeNutrition=true" +
        '&offset=' +
        offset +
        '&number=1&apiKey=' +
        apiKey;

    print(searchURL);
    if (searchURL.contains('rapidapi')) {
      _headers = {
        "content-type": "application/json",
        "x-rapidapi-host":
            "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "x-rapidapi-key": apiKey,
      };
    }
    final result = await http.get(searchURL,
        headers: searchURL.contains('rapidapi') ? _headers : null);

    if (result.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(result.body);

      for (Map<String, dynamic> obj in data['results']) {
        Recipe newRecipe = new Recipe(
          id: obj['id'].toString(),
          imageUrl: obj['image'],
          name: obj['title'],
          cookTime: obj['readyInMinutes'],
          servings: obj['servings'],
        );

        print(obj['title']);

        newRecipe.ingredients = getIngredientsOffline(obj['nutrition']);
        newRecipe.instruction =
            getInstructionsOffline(obj['analyzedInstructions']);

        List<String> summary =
            obj['summary'].toString().split(new RegExp('<b>'));
        newRecipe.calories = double.parse(
            summary[summary.indexWhere((test) => test.contains('calories'))]
                .split(' ')[0]);
        cuisineRecipes.add(newRecipe);
      }
    } else {
      print(
          'Failed to load Recipe. Resp Code: ' + result.statusCode.toString());

      throw FlutterError('Response Code: ' + result.statusCode.toString());
    }
  }

  return cuisineRecipes;
}
