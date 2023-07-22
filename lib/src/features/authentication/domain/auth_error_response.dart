import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_recipes/src/api/api_error_response.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

final List<String> test = ["Password is not good"];

class ValidationErrors2 {
  Map<String, dynamic> errors;
  ValidationErrors2({
    required this.errors,
  });

  void test() {
    final errors = {
      "email": ["Email is not good"],
      "password": ["Password is not good"]
    };
  }

  ValidationErrors2 copyWith({
    Map<String, dynamic>? errors,
  }) {
    return ValidationErrors2(
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errors': errors,
    };
  }

  factory ValidationErrors2.fromMap(Map<String, dynamic> map) {
    return ValidationErrors2(
      errors: Map<String, dynamic>.from(
        map,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidationErrors2.fromJson(String source) =>
      ValidationErrors2.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ValidationErrors2(errors: $errors)';

  @override
  bool operator ==(covariant ValidationErrors2 other) {
    if (identical(this, other)) return true;

    return mapEquals(other.errors, errors);
  }

  @override
  int get hashCode => errors.hashCode;
}

// class AuthValidationErrors {
//   AuthValidationErrors({
//     required this.email,
//     required this.password,
//   });

//   List<String> email;
//   List<String> password;
// }

// abstract class AbstractApiError {
//   AbstractApiError(this.status, this.title, this.traceId, this.type);

//   final int status;
//   final String title;
//   final String traceId;
//   final String type;
// }

class AuthErrorResponse extends ApiErrorResponse {
  AuthErrorResponse({
    required int status,
    required String title,
    required String traceId,
    required String type,
    this.validationErrors,
  }) : super(status: status, title: title, traceId: traceId, type: type);

  final ValidationErrors2? validationErrors;

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'validationErrors': validationErrors?.toMap(),
    };
  }

  factory AuthErrorResponse.fromMap(Map<String, dynamic> map) {
    return AuthErrorResponse(
      status: map['status'] as int,
      title: map['title'] as String,
      traceId: map['traceId'] as String,
      type: map['type'] as String,
      validationErrors: map['errors'] != null
          ? ValidationErrors2.fromMap(map['errors'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AuthErrorResponse.fromJson(String source) =>
      AuthErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthErrorResponse(status: $status, title: $title, traceId: $traceId, type: $type, validationErrors: $validationErrors)';
}
