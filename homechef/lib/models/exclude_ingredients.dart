class ExcludeIngredient {
  String name;

  ExcludeIngredient({
    this.name,
  });

  factory ExcludeIngredient.fromJson(Map<String, dynamic> json) {

    return new ExcludeIngredient(
      name: json['name'],
    );
  }
}

final List<ExcludeIngredient> exclIngredients = [
  ExcludeIngredient(name: "Eggs"),
  ExcludeIngredient(name: "Milk"),
  ExcludeIngredient(name: "Dairy"),
  ExcludeIngredient(name: "Cheese"),
  ExcludeIngredient(name: "Meat"),
  ExcludeIngredient(name: "Fish"),
  ExcludeIngredient(name: "Sugar"),
];
