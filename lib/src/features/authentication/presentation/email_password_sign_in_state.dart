// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/authentication/presentation/string_validators.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';

enum EmailPasswordSignInFormType { signIn, register }

// Create string validator that checks toString().trim().isEmpty

mixin EmailPasswordValidators {
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(6);
  final StringValidator passwordRegisterSubmitValidator2 =
      PasswordRegisterSubmitRegexValidator();
  final StringValidator passwordLoginSubmitValidator =
      NonEmptyStringValidator();
}

class EmailPasswordSignInState with EmailPasswordValidators {
  EmailPasswordSignInState({
    required this.formType,
    this.value = const AsyncData(null),
    this.errorMessage,
    this.apiPasswordValidationErrors,
    this.apiEmailValidationErrors,
  });

  final EmailPasswordSignInFormType formType;
  final AsyncValue<void> value;

  //  Error message from the API
  final String? errorMessage;

  // Validation error messages from the API
  final List<dynamic>? apiPasswordValidationErrors;
  final List<dynamic>? apiEmailValidationErrors;

  EmailPasswordSignInState copyWith({
    EmailPasswordSignInFormType? formType,
    AsyncValue<void>? value,
    String? errorMessage,
    List<dynamic>? apiPasswordValidationErrors,
    List<dynamic>? apiEmailValidationErrors,
  }) {
    return EmailPasswordSignInState(
      formType: formType ?? this.formType,
      value: value ?? this.value,
      errorMessage: errorMessage ?? this.errorMessage,
      apiPasswordValidationErrors:
          apiPasswordValidationErrors ?? this.apiPasswordValidationErrors,
      apiEmailValidationErrors:
          apiEmailValidationErrors ?? this.apiEmailValidationErrors,
    );
  }

  @override
  bool operator ==(covariant EmailPasswordSignInState other) {
    if (identical(this, other)) return true;

    return other.formType == formType &&
        other.value == value &&
        other.errorMessage == errorMessage &&
        other.apiPasswordValidationErrors == apiPasswordValidationErrors &&
        other.apiEmailValidationErrors == apiEmailValidationErrors;
  }

  @override
  int get hashCode => formType.hashCode ^ value.hashCode;
}

extension EmailPasswordSignInStateX on EmailPasswordSignInState {
  String get errorBoxText => "Invalid credentials".hardcoded;

  String get titleText {
    return formType == EmailPasswordSignInFormType.signIn
        ? "Log in to an existing account"
        : "Create an account";
  }

  String get primaryButtonText {
    return formType == EmailPasswordSignInFormType.signIn
        ? "Log in"
        : "Register";
  }

  String get secondaryText {
    return formType == EmailPasswordSignInFormType.signIn
        ? "Don't have an account?"
        : "Already have an account?";
  }

  String get tertiaryButtonText {
    return formType == EmailPasswordSignInFormType.signIn
        ? "Register"
        : "Log in";
  }

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPassword(String password) {
    return formType == EmailPasswordSignInFormType.signIn
        ? passwordLoginSubmitValidator.isValid(password)
        : passwordRegisterSubmitValidator2.isValid(password);
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);

    final String errorText = email.isEmpty
        ? "Email can't be empty".hardcoded
        : "Please enter a valid email address".hardcoded;

    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(String password) {
    final bool showErrorText = !canSubmitPassword(password);

    final String errorText = password.isEmpty
        ? "Password can't be empty".hardcoded
        : "Password must be between 6 to 18 characters, and must contain a capital letter and a number"
            .hardcoded;

    return showErrorText ? errorText : null;
  }

  String? apiEmailValidationErrorText() {
    return apiEmailValidationErrors?.isNotEmpty == true
        ? apiEmailValidationErrors?.first
        : null;
  }

  String? apiPasswordValidationErrorText() {
    return apiPasswordValidationErrors?.isNotEmpty == true
        ? apiPasswordValidationErrors?.first
        : null;
  }
}
