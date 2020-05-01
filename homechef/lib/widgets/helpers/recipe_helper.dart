  import 'package:homechef/models/ingredients/ingredient_model.dart';
import 'package:homechef/models/instructions/instruction_model.dart';

String parseIngredients(List<Ingredient> ingredients) {
    String res = '';

    for (var ingredient in ingredients) {
      res = res +
          ingredient.name.substring(0, 1).toUpperCase() +
          ingredient.name.substring(1) +
          '\n\n';
    }
    return res;
  }

  String parseAmount(List<Ingredient> ingredients) {
    String res = '';

    for (var ingredient in ingredients) {
      res = res + ingredient.amount.toString() + ' ' + ingredient.unit + '\n\n';
    }
    return res;
  }

  String parseInstruction(List<Instruction> instructions) {
    String res = '';

    for (var index = 1; index <= instructions.length; index++) {
      res = res + '\u2022 \t\t' + instructions[index - 1].instruction + '\n\n';
    }
    return res;
  }