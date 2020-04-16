class Ingredient {
  String id;
  String imageUrl;
  String name;
  double amount;
  String unit;

  Ingredient({
    this.id,
    this.imageUrl,
    this.name,
    this.amount,
    this.unit
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {

    return new Ingredient(
      id: json['id'].toString(),
      imageUrl: json['imageUrl'],
      name: json['name'],
    );
  }
}

