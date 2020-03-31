import 'ingredients/ingredient_model.dart';
import 'instructions/instruction_model.dart';

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
    this.ingredients,
    this.instruction
  });

  // factory Recipe.fromJson(Map<String, dynamic> json) {

  //   var ingredient_list = json['ingredients'] as List;
  //   List<Ingredient> ingredients = ingredient_list.map((f) => Ingredient.fromJson(f)).toList();

  //   var instruction_list = json['instructions'] as List;
  //   List<Instruction> instructions = instruction_list.map((f) => Instruction.fromJson(f)).toList();

  //   return new Recipe(
      
  //     id: json['id'].toString(),
  //     imageUrl: json['imageUrl'],
  //     name: json['name'],
  //     rate: 5,
  //     cookTime: 15,
  //     description: 'This is a sample text',
  //     instruction: instructions,
  //     ingredients: ingredients,
  //   );
  // }
}

