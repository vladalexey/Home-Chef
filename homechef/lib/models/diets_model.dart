import 'package:homechef/models/diet_model.dart';

class Diets {

  void setAllFalseExcept(Diet diet) {

    for (String key in dietOptions.keys) {
      if (key != encodeDietName(diet.name)) dietOptions[key] = false;
    }
    dietOptions[encodeDietName(diet.name)] = !dietOptions[encodeDietName(diet.name)];
  }

  void setAllFalse() {
    for (String key in dietOptions.keys) dietOptions[key] = false;
  }

  Diet getDiet(String diet) {
    for (Diet _diet in diets) if (diet == _diet.name) return _diet;
    return null;
  }
}

Map<String, bool> dietOptions = {
  'veganBool': false, 
  'vegetarianBool': false, 
  'ovoVegetarianBool': false, 
  'lactoVegetarianBool': false, 
  'glutenFreeBool': false, 
  'paleoBool': false, 
  'pescetarianBool': false, 
  'primalBool': false, 
  'whole30Bool': false, 
  'ketoBool': false
};
