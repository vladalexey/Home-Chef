class IncludeIngredient {
  String name;

  IncludeIngredient({
    this.name,
  });

  factory IncludeIngredient.fromJson(Map<String, dynamic> json) {

    return new IncludeIngredient(
      name: json['name'],
    );
  }
}

final List<IncludeIngredient> inclIngredients = [
  IncludeIngredient(name: "Vegetable"),
  IncludeIngredient(name: "Butter"),
  IncludeIngredient(name: "Fruit"),
  IncludeIngredient(name: "Eggs"),
  IncludeIngredient(name: "Milk"),
  IncludeIngredient(name: "Dairy"),
  IncludeIngredient(name: "Cheese"),
  IncludeIngredient(name: "Meat"),
  IncludeIngredient(name: "Fish"),
  IncludeIngredient(name: "Sugar"),
];
