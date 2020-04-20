class Nutrient {
  String name;
  double amount;
  String unit;

  Nutrient({
    this.name,
    this.amount,
    this.unit
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) {

    return new Nutrient(
      name: json['title'],
      amount: json['amount'],
      unit: json['unit']
    );
  }
}

