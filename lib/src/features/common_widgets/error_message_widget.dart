import 'package:flutter/material.dart';
import 'package:my_recipes/src/api/api_error_response.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';

/// Shows a centered error message.
class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}

/// Shows an error screen with a scaffold and an error message.
class ErrorScreenWidget extends StatefulWidget {
  const ErrorScreenWidget({
    super.key,
    required this.error,
    this.onDispose,
  });
  final Object error;
  final VoidCallback? onDispose;

  @override
  State<ErrorScreenWidget> createState() => _ErrorScreenWidgetState();
}

class _ErrorScreenWidgetState extends State<ErrorScreenWidget> {
  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ErrorScreenWidget: ${widget.error.toString()}");
    final isApiResponse = widget.error is ApiErrorResponse;

    return Scaffold(
      appBar: AppBar(
        title: Text("Error".hardcoded),
      ),
      body: Center(
        child: ErrorMessageWidget(
          errorMessage: isApiResponse
              ? (widget.error as ApiErrorResponse).title
              : widget.error.toString(),
        ),
      ),
    );
  }
}
