import 'package:formz/formz.dart';

enum FirstNameError { invalid }

class FirstName extends FormzInput<String, FirstNameError> {
  const FirstName.pure([String value = '']) : super.pure(value);
  const FirstName.dirty([String value = '']) : super.dirty(value);

  @override
  FirstNameError? validator(String value) {
    return value.isNotEmpty ? null : FirstNameError.invalid;
  }
}