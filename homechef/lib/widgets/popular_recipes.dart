import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:homechef/models/nutrients/nutrients_list_model.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:ultimate_data_generator/ultimate_data_generator.dart';


Future<String> getFileData(String path) async {
  return await rootBundle.loadString(path);
}

Future<List<Recipe>> getPopularRecipes(int numberRecipes) async {

  List<Recipe> popularRecipes = List<Recipe>();
  String apiKey = await getFileData('assets/API_KEY.txt');
  Map<String, String> _headers;

  

  Random random = new Random();
  
  String baseURL = 'https://api.spoonacular.com';
    // String baseURL = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';

  for (int index = 0; index < numberRecipes; index++) {

    print(Faker().food.dish());

    List<String> generateFood = [
    FoodGen.generateNonVegetarianMainMealFoodName(), 
    FoodGen.generateNonVegetarianSnacksFoodName(),
    FoodGen.generateNonVegetarianStarterFoodName(),
    FoodGen.generateVeganMainMealFoodName(),
    FoodGen.generateVeganSnacksFoodName(),
    FoodGen.generateVegetarianSnacksFoodName()
    ];

    String chosenFoodName = generateFood[random.nextInt(generateFood.length)].split(' ')[generateFood[random.nextInt(generateFood.length)].split(' ').length - 1];
    String offset = random.nextInt(20).toString();
    
    String searchURL = baseURL +
        '/recipes/complexSearch?' +
        'query=' + chosenFoodName +
        '&sort=popularity' +
        '&sortDirection=desc' +
        "&addRecipeInformation=true&addRecipeNutrition=true" +
        '&offset=' + offset +
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

        List<String> summary = obj['summary'].toString().split(new RegExp('<b>'));
        newRecipe.calories = double.parse(summary[summary.indexWhere((test) => test.contains('calories'))].split(' ')[0]);
        popularRecipes.add(newRecipe);
      }
    } else {
      print('Failed to load Recipe. Resp Code: ' +
          result.statusCode.toString());

      throw FlutterError('Response Code: ' + result.statusCode.toString());
    }
  }

  return popularRecipes;
} 