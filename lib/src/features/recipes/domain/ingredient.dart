// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ingredient {
  Ingredient({
    required this.amount,
    required this.unit,
    required this.name,
  });

  final String amount;
  final String unit;
  final String name;

  Ingredient copyWith({
    String? amount,
    String? unit,
    String? name,
  }) {
    return Ingredient(
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'unit': unit,
      'name': name,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      amount: map['amount'] as String,
      unit: map['unit'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Ingredient(amount: $amount, unit: $unit, name: $name)';

  @override
  bool operator ==(covariant Ingredient other) {
    if (identical(this, other)) return true;

    return other.amount == amount && other.unit == unit && other.name == name;
  }

  @override
  int get hashCode => amount.hashCode ^ unit.hashCode ^ name.hashCode;
}
