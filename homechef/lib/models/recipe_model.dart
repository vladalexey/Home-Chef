import 'dart:convert';

import 'package:homechef/models/ingredients/ingredient_list_model.dart';
import 'package:homechef/models/instructions/instruction_list_model.dart';

import 'ingredients/ingredient_model.dart';
import 'instructions/instruction_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

Future<String> getFileData(String path) async {
  return await rootBundle.loadString(path);
}

class Recipe {
  String id;
  String imageUrl;
  String name;
  String description;
  int rate;
  int cookTime;
  List<Ingredient> ingredients;
  List<Instruction> instruction;

  Recipe({
    this.id,
    this.imageUrl,
    this.name,
    this.rate = 4,
    this.cookTime = 45,
    this.description,
    this.ingredients = const [],
    this.instruction = const [],
  });
}

Future<List<Ingredient>> getIngredients(Recipe recipe) async {

  String apiKey = await getFileData('assets/API_KEY_RAPIDAPI.txt');
  String baseURL = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';
  
  Map<String, String> _headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
    "x-rapidapi-key": apiKey,
  };

  final ingredientResp = await http.get(
    baseURL + '/recipes/' + recipe.id.toString() + '/ingredientWidget.json?apiKey=' + apiKey,
    headers: baseURL.contains('rapidapi') ? _headers : null);
  
  if (ingredientResp.statusCode == 200) {
    recipe.ingredients = IngredientList.fromJson(json.decode(ingredientResp.body)).ingredients;
  } else {
    print('Failed to get ingredients ' + ingredientResp.statusCode.toString());
  }
  return recipe.ingredients;
}

Future<List<Instruction>> getInstructions(Recipe recipe) async {

  String apiKey = await getFileData('assets/API_KEY_RAPIDAPI.txt');
  String baseURL = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';
  Map<String, String> _headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
    "x-rapidapi-key": apiKey,
  };

  final instructionResp = await http.get(
    baseURL + '/recipes/' + recipe.id.toString() + '/analyzedInstructions?apiKey=' + apiKey,
    headers: baseURL.contains('rapidapi') ? _headers : null);
  
  if (instructionResp.statusCode == 200) {
    recipe.instruction = InstructionList.fromJson(json.decode(instructionResp.body)).instructions;
  } else {
    print('Failed to get instructions ' + instructionResp.statusCode.toString());
  }
  return recipe.instruction;
}