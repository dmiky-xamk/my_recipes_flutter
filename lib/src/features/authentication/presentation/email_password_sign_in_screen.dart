import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/constants/app_themes.dart';
import 'package:my_recipes/src/features/authentication/presentation/email_password_sign_in_controller.dart';
import 'package:my_recipes/src/features/authentication/presentation/email_password_sign_in_state.dart';
import 'package:my_recipes/src/features/common_widgets/error_box.dart';
import 'package:my_recipes/src/features/common_widgets/primary_button.dart';
import 'package:my_recipes/src/routing/app_router.dart';
import 'package:my_recipes/src/utils/async_value_ui.dart';

class EmailPasswordSignInScreen extends ConsumerStatefulWidget {
  const EmailPasswordSignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmailPasswordSignInScreenState();
}

class _EmailPasswordSignInScreenState
    extends ConsumerState<EmailPasswordSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

  bool _submitted = false;
  bool showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateFormType() {
    ref.read(emailPasswordSignInControllerProvider.notifier).updateFormType();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(emailPasswordSignInControllerProvider.notifier);
      final success = await controller.submit(email, password);
      if (success == true) {
        // Redirect
        if (context.mounted) {
          context.goNamed(AppRoute.recipes.name);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      emailPasswordSignInControllerProvider.select((state) => state.value),
      (_, state) => state.showAlertDialogOnError(
        context,
        title: "Authentication failed",
        actionText: "Try again",
      ),
    );

    final state = ref.watch(emailPasswordSignInControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: Form(
        autovalidateMode:
            _submitted ? AutovalidateMode.onUserInteraction : null,
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  state.titleText,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                gapH32,
                TextFormField(
                  autocorrect: false,
                  controller: _emailController,
                  decoration: InputDecoration(
                    errorMaxLines: 3,
                    errorText: state.apiEmailValidationErrorText(),
                    labelText: "Email",
                  ),
                  enabled: state.value.isLoading ? false : true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  // validator: (email) => state.emailErrorText(email ?? ""),
                ),
                gapH16,
                TextFormField(
                  autocorrect: false,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    errorMaxLines: 3,
                    errorText: state.apiPasswordValidationErrorText(),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: showPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      color: medium,
                      onPressed: () =>
                          setState(() => showPassword = !showPassword),
                    ),
                  ),
                  enabled: state.value.isLoading ? false : true,
                  obscureText: !showPassword,
                  textInputAction: TextInputAction.done,
                  // validator: (password) =>
                  //     state.passwordErrorText(password ?? ""),
                ),
                gapH16,
                if (state.errorMessage != null)
                  ErrorBox(text: state.errorMessage!),
                PrimaryButton(
                  isLoading: state.value.isLoading,
                  text: state.primaryButtonText,
                  onPressed: _submit,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.secondaryText,
                    ),
                    TextButton(
                      onPressed: state.value.isLoading ? null : _updateFormType,
                      child: Text(
                        state.tertiaryButtonText,
                        style: TextStyle(
                          color: state.value.isLoading ? medium : null,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
