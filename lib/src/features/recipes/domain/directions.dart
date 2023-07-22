// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Direction {
  Direction({
    required this.step,
  });

  final String step;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'step': step,
    };
  }

  factory Direction.fromMap(Map<String, dynamic> map) {
    return Direction(
      step: map['step'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Direction.fromJson(String source) =>
      Direction.fromMap(json.decode(source) as Map<String, dynamic>);

  Direction copyWith({
    String? step,
  }) {
    return Direction(
      step: step ?? this.step,
    );
  }

  @override
  String toString() => 'Direction(step: $step)';

  @override
  bool operator ==(covariant Direction other) {
    if (identical(this, other)) return true;

    return other.step == step;
  }

  @override
  int get hashCode => step.hashCode;
}
