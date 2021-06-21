import 'package:formz/formz.dart';

enum FullNameError { invalid }

class FullName extends FormzInput<String, FullNameError> {
  const FullName.pure([String value = '']) : super.pure(value);
  const FullName.dirty([String value = '']) : super.dirty(value);

  @override
  FullNameError? validator(String value) {
    return value.isNotEmpty ? null : FullNameError.invalid;
  }
}