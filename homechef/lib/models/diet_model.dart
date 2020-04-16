import 'package:flutter/material.dart';
import 'package:homechef/models/recipe_model.dart';
import 'package:homechef/widgets/search_widgets/bounce_button.dart';

class Diet {
  String imageUrl;
  String name;
  String description;
  List<Recipe> recipes;

  Diet({
    this.imageUrl,
    this.name,
    this.description,
    this.recipes,
  });
}

Map<String, bool> dietOptions = {'veganBool': false, 'vegetarianBool': false, 'ovoVegetarianBool': false, 'lactoVegetarianBool': false, 'glutenFreeBool': false, 
  'paleoBool': false, 'pescetarianBool': false, 'primalBool': false, 'whole30Bool': false, 'ketoBool': false};

void setAllFalse() {
  for (String key in dietOptions.keys) {
    dietOptions[key] = false;
  }
}

String encodeDietName(String name) {

  return name.substring(0, 1).toLowerCase() + name.substring(1, name.length).replaceAll(' ', '') + 'Bool';
}

List<AnimatedButton> getDietButtons(List<AnimationController> parentControllers) {

  return List<AnimatedButton>.generate(
    diets.length, (int index,) {
    
      return AnimatedButton(
        chosenDiet: dietOptions[encodeDietName(diets[index].name)],
        parentController: parentControllers[index],
        parentControllers: parentControllers,
        onTap: () {

          if (dietOptions[encodeDietName(diets[index].name)] == false) {
            setAllFalse();
          }
          dietOptions[encodeDietName(diets[index].name)] = !dietOptions[encodeDietName(diets[index].name)];

          print(dietOptions);

        },

        animationDuration: const Duration(milliseconds: 500),
        initialText: diets[index].name,
        finalText: diets[index].name,
        iconData: Icons.check,
        iconSize: 18.0,

        buttonStyle: ButtonStyle(
          primaryColor: Colors.white,
          secondaryColor: Colors.amber[300],
          elevation: 5.0,
          initialTextStyle: TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
          finalTextStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.black87,
          ),
          borderRadius: 10.0,
        ),
      );
    } 
  ); 
}

// void assignControllerDietButtons(List<AnimationController> parentControllers) {
//   dietButtons.forEach( (AnimatedButton button) {
//     button.parentController = parentControllers[dietButtons.indexOf(button)];
//   });
// }

final List<Recipe> recipes = [
  Recipe(
    id: '1',
    imageUrl: 'assets/imgs/food4.jpg',
    name: 'Sushi',
    description: 'Lorem ipsum dolor sit amet.',
    calories: 150,
    servings: 4,
    ingredients: [],
    instruction: []
  ),
  Recipe(
    id: '2',
    imageUrl: 'assets/imgs/food5.jpg',
    name: 'Yellow Curry',
    description: 'Lorem ipsum dolor sit amet.',
    calories: 480,
    servings: 2,
    ingredients: [],
    instruction: []
  ),
  Recipe(
    id: '3',
    imageUrl: 'assets/imgs/food6.jpg',
    name: 'Cheeseburger',
    description: 'Lorem ipsum dolor sit amet.',
    calories: 350,
    servings: 6,
    ingredients: [],
    instruction: []
  ),
  Recipe(
    id: '4',
    imageUrl: 'assets/imgs/food4.jpg',
    name: 'Sushi',
    description: 'Lorem ipsum dolor sit amet.',
    calories: 350,
    servings: 5,
    ingredients: [],
    instruction: []
  ),
  Recipe(
    id: '5',
    imageUrl: 'assets/imgs/food5.jpg',
    name: 'Yellow Curry',
    calories: 150,
    servings: 4,
    description: 'Lorem ipsum dolor sit amet.',
    ingredients: [],
    instruction: []
  ),
  Recipe(
    id: '6',
    imageUrl: 'assets/imgs/food6.jpg',
    name: 'Cheeseburger',
    description: 'Lorem ipsum dolor sit amet.',
    calories: 120,
    servings: 2,
    ingredients: [],
    instruction: []
  ),
];

final List<Diet> diets = [
  Diet(
    imageUrl: 'assets/imgs/glutenfree.jpg',
    name: 'Gluten Free',
    description: 'Eliminating gluten means avoiding wheat, barley, rye, and other gluten-containing grains and foods made from them',
    recipes: recipes,
    ),
  Diet(
    imageUrl: 'assets/imgs/keto.jpg',
    name: 'Keto',
    description: 'High fat, protein-rich foods are acceptable and high carbohydrate foods are not.',
    recipes: recipes,
    ),
  Diet(
    imageUrl: 'assets/imgs/vegan.jpg',
    name: 'Vegan',
    description: 'Lorem ipsum dolor sit amet.',
    recipes: recipes,
    ),

  Diet(
    imageUrl: 'assets/imgs/vegetarian.png',
    name: 'Vegetarian',
    description: 'No ingredients may contain meat or meat by-products, such as bones or gelatin.',
    recipes: recipes,
    ),

    Diet(
    imageUrl: 'assets/imgs/lactovegetarian.jpg',
    name: 'Lacto Vegetarian',
    description: 'All ingredients must be vegetarian and none of the ingredients can be or contain egg.',
    recipes: recipes,
    ),

    Diet(
    imageUrl: 'assets/imgs/ovovegetarian.png',
    name: 'Ovo Vegetarian',
    description: 'All ingredients must be vegetarian and none of the ingredients can be or contain dairy.',
    recipes: recipes,
    ),
 
    Diet(
    imageUrl: 'assets/imgs/pescetarian.jpg',
    name: 'Pescetarian',
    description: 'Everything is allowed except meat and meat by-products - some pescetarians eat eggs and dairy, some do not.',
    recipes: recipes,
    ),

    Diet(
    imageUrl: 'assets/imgs/paleo.jpeg',
    name: 'Paleo',
    description: 'Ingredients not allowed include legumes (e.g. beans and lentils), grains, dairy, refined sugar, and processed foods.',
    recipes: recipes,
    ),

    Diet(
    imageUrl: 'assets/imgs/primal.jpg',
    name: 'Primal',
    description: 'Very similar to Paleo, except dairy is allowed ',
    recipes: recipes,
    ),

    Diet(
    imageUrl: 'assets/imgs/whole30.jpg',
    name: 'Whole30',
    description: 'Ingredients not allowed include added sweeteners (natural and artificial, ' + 
                    'except small amounts of fruit juice), dairy (except clarified butter or ghee), alcohol, grains, legumes (except green beans, sugar snap peas, and snow peas), ' + 
                    'and food additives, such as carrageenan, MSG, and sulfites.',
    recipes: recipes,
    ),
];