abstract class StringValidator {
  bool isValid(String value);
}

class MinLengthStringValidator implements StringValidator {
  MinLengthStringValidator(this.minLength);

  final int minLength;

  @override
  bool isValid(String value) {
    return value.trim().length >= minLength;
  }
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.trim().isNotEmpty;
  }
}

class RegexValidator implements StringValidator {
  RegexValidator({required this.regexSource});
  final String regexSource;

  @override
  bool isValid(String value) {
    try {
      // https://regex101.com/
      final RegExp regex = RegExp(regexSource);
      final Iterable<Match> matches = regex.allMatches(value);
      for (final match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class EmailEditingRegexValidator extends RegexValidator {
  EmailEditingRegexValidator() : super(regexSource: '^(|\\S)+\$');
}

class EmailSubmitRegexValidator extends RegexValidator {
  EmailSubmitRegexValidator() : super(regexSource: '^\\S+@\\S+\\.\\S+\$');
}

class PasswordRegisterSubmitRegexValidator extends RegexValidator {
  PasswordRegisterSubmitRegexValidator()
      : super(regexSource: "^(?=.[A-Z])(?=.\\d).{6,18}\$");
}
