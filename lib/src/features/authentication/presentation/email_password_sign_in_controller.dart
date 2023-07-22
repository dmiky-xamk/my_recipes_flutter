import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/authentication/data/auth_repository.dart';
import 'package:my_recipes/src/features/authentication/domain/auth_error_response.dart';
import 'package:my_recipes/src/features/authentication/presentation/email_password_sign_in_state.dart';

// enum EmailPasswordSignInFormType { signIn, register }

class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  EmailPasswordSignInController({required this.authRepository})
      : super(
          EmailPasswordSignInState(
            formType: EmailPasswordSignInFormType.register,
          ),
        );

  final AuthRepository authRepository;

  Future<bool> submit(String email, String password) async {
    state = state.copyWith(value: const AsyncLoading());
    final value = await AsyncValue.guard(() => _authenticate(email, password));

    debugPrint("Value.Error: ${value.error.toString()}");
    if (value.error is AuthErrorResponse) {
      final authError = value.error as AuthErrorResponse;

      state = state.copyWith(
        value: value,
        errorMessage: authError.title,
        apiEmailValidationErrors:
            authError.validationErrors?.errors['Email'] ?? [],
        apiPasswordValidationErrors:
            authError.validationErrors?.errors['Password'] ?? [],
      );
    } else {
      state = state.copyWith(value: value);
    }

    return value.hasError == false;
  }

  Future<void> _authenticate(String email, String password) async {
    debugPrint("Email: $email, Password: $password");
    if (state.formType == EmailPasswordSignInFormType.signIn) {
      await authRepository.signInWithEmailAndPassword(email, password);
    } else if (state.formType == EmailPasswordSignInFormType.register) {
      await authRepository.createUserWithEmailAndPassword(email, password);
    }
  }

  void updateFormType() {
    if (state.formType == EmailPasswordSignInFormType.signIn) {
      state = state.copyWith(formType: EmailPasswordSignInFormType.register);
    } else {
      state = state.copyWith(formType: EmailPasswordSignInFormType.signIn);
    }
  }
}

final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose<
    EmailPasswordSignInController, EmailPasswordSignInState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return EmailPasswordSignInController(authRepository: authRepository);
});
