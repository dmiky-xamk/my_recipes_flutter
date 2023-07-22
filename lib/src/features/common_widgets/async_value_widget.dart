import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/common_widgets/error_message_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {super.key, required this.value, required this.data, this.error});
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function(Object)? error;

  @override
  Widget build(BuildContext context) {
    return value.when(
        data: data,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          if (this.error != null) {
            return this.error!(error);
          } else {
            return ErrorMessageWidget(errorMessage: error.toString());
          }
        });
  }
}
