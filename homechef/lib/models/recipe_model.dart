class Recipe {
  String id;
  String imageUrl;
  String name;
  String description;
  int rate;
  int cookTime;
  List<String> ingredients;
  String instruction;

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
}

