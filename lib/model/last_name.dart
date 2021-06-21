import 'package:formz/formz.dart';

enum LastNameError { invalid }

class LastName extends FormzInput<String, LastNameError> {
  const LastName.pure([String value = '']) : super.pure(value);
  const LastName.dirty([String value = '']) : super.dirty(value);

  @override
  LastNameError? validator(String value) {
    return value.isNotEmpty ? null : LastNameError.invalid;
  }
}