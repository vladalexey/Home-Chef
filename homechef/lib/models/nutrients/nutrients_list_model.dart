import 'package:homechef/models/nutrients/nutrients_model.dart';

class NutrientList {
  final List<Nutrient> nutrients;

  NutrientList({
    this.nutrients
  });

  factory NutrientList.fromJson(Map<String, dynamic> nutrientResult) {

    List<Nutrient> nutrients = [];

    // print('JSON DECOD ----------------------\n' + nutrientResult.toString());

    List<Map> nutrient_objs = new List<Map>.from(nutrientResult['nutrients']);
    for (Map<String, dynamic> nutrient_obj in nutrient_objs) {
      
      Nutrient nutrient = new Nutrient(
        name: nutrient_obj['title'],
        unit: nutrient_obj['unit'],
        amount: nutrient_obj['amount']
      );

      nutrients.add(nutrient);
    }

    return NutrientList(nutrients: nutrients);  
  }

  double getCalories() {
    for (Nutrient nutrient in this.nutrients) if (nutrient.name == 'Calories') return nutrient.amount;
    return 0;
  }
}