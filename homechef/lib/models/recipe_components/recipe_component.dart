class RecipeComponent {
  String id;
  String steps;

  RecipeComponent({
    this.id,
    this.steps,
  });

  factory RecipeComponent.fromJson(Map<String, dynamic> json) {

    var list = json['steps'] as List;
    
    return new RecipeComponent(
      id: json['name'],
      steps: json['steps'],
    );
  }
}

