class Ingredient {
  String id;
  String imageUrl;
  String name;

  Ingredient({
    this.id,
    this.imageUrl,
    this.name,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return new Ingredient(
      id: json['id'].toString(),
      imageUrl: json['imageUrl'],
      name: json['name'],
    );
  }
}

