import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/api/api_error_response.dart';
import 'package:my_recipes/src/features/common_widgets/alert_dialogs.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(
    BuildContext context, {
    String? title,
    String? actionText,
  }) {
    final message = _errorMessage(error);
    if (!isLoading && hasError) {
      showExceptionAlertDialog(
        context: context,
        title: title ?? 'Error'.hardcoded,
        actionText: actionText,
        exception: message,
      );
    }
  }

  String _errorMessage(Object? error) {
    // TODO: Decide error type
    if (error is ApiErrorResponse) {
      // AbstractApiError
      return error.title;
    } else {
      return error.toString();
    }
  }
}
