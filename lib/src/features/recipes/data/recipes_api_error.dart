class APIException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const APIException(this.message, [this.stackTrace]);

  @override
  String toString() => message;
}

class UnauthorizedException extends APIException {
  const UnauthorizedException([
    String message = "Sorry, you are not authorized",
    StackTrace? stackTrace,
  ]) : super(message, stackTrace);
}

class NoInternetConnectionException extends APIException {
  const NoInternetConnectionException([String? message, StackTrace? stackTrace])
      : super('No internet connection', stackTrace);
}

class RecipeNotFoundException extends APIException {
  const RecipeNotFoundException([String? message, StackTrace? stackTrace])
      : super("Didn't find the recipe", stackTrace);
}

class UnknownErrorException extends APIException {
  const UnknownErrorException([String? message, StackTrace? stackTrace])
      : super("An unknown error happened", stackTrace);
}
