import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:sync_texrt_field/model/model.dart';

part 'sync_text_field_event.dart';
part 'sync_text_field_state.dart';

class SyncTextFieldBloc extends Bloc<SyncTextFieldEvent, SyncTextFieldState> {
  SyncTextFieldBloc() : super(const SyncTextFieldState.initial());


  final TextEditingController fullNameBlocController = TextEditingController();
  final TextEditingController firstNameBlocController = TextEditingController();
  final TextEditingController lastNameBlocController = TextEditingController();

  @override
  Future<void> close() {
    fullNameBlocController.dispose();
    firstNameBlocController.dispose();
    lastNameBlocController.dispose();
    return super.close();
  }

  @override
  void onTransition(Transition<SyncTextFieldEvent, SyncTextFieldState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<SyncTextFieldState> mapEventToState(
    SyncTextFieldEvent event,
  ) async* {
    if(event is FullNameChanged) {

      final name = fullNameBlocController.value.text;

      List<String> extractedName = name.split(RegExp(r"(?=(?!^)[A-Z])"));

      print(extractedName);

      final fullName = FullName.dirty(name);
      final firstName = FirstName.dirty(extractedName[0]);
      final lastName = LastName.dirty(extractedName.getRange(1, extractedName.length).join(""));


      fullNameBlocController.value = TextEditingValue(
        text: fullName.value,
        selection: TextSelection.collapsed(offset: fullName.value.length)
      );
      firstNameBlocController.value = TextEditingValue(
        text: firstName.value,
        selection: TextSelection.collapsed(offset: firstName.value.length)
      );
      lastNameBlocController.value = TextEditingValue(
        text: lastName.value,
        selection: TextSelection.collapsed(offset: lastName.value.length)
      );


      yield state.copyWith(
          fullName: fullName.valid ? fullName: FullName.pure(fullName.value),
          firstName: firstName.valid ? firstName: FirstName.pure(firstName.value),
          lastName: lastName.valid ? lastName: LastName.pure(lastName.value),
          status: Formz.validate([fullName, firstName, lastName])
      );
    }
    else if (event is FirstNameChanged) {
      final first = firstNameBlocController.value.text;
      final last = state.lastName!.value;
      final full = "$first $last";

      final fullName = FullName.dirty(full);
      final firstName = FirstName.dirty(first);
      final lastName = LastName.dirty(last);

      fullNameBlocController.value = TextEditingValue(
        text: fullName.value,
        selection: TextSelection.collapsed(offset: fullName.value.length)
      );
      firstNameBlocController.value = TextEditingValue(
        text: firstName.value,
        selection: TextSelection.collapsed(offset: firstName.value.length)
      );
      lastNameBlocController.value = TextEditingValue(
        text: lastName.value,
        selection: TextSelection.collapsed(offset: lastName.value.length)
      );

      yield state.copyWith(
          fullName: fullName.valid ? fullName: FullName.pure(fullName.value),
          firstName: firstName.valid ? firstName: FirstName.pure(firstName.value),
          status: Formz.validate([fullName, firstName, state.lastName!])
      );
    }
    else if (event is LastNameChanged) {
      final first = state.firstName!.value;
      final last = lastNameBlocController.value.text;
      final full = "$first $last";

      final fullName = FullName.dirty(full);
      final firstName = FirstName.dirty(first);
      final lastName = LastName.dirty(last);

      fullNameBlocController.value = TextEditingValue(
        text: fullName.value,
        selection: TextSelection.collapsed(offset: fullName.value.length)
      );
      firstNameBlocController.value = TextEditingValue(
        text: firstName.value,
        selection: TextSelection.collapsed(offset: firstName.value.length)
      );
      lastNameBlocController.value = TextEditingValue(
        text: lastName.value,
        selection: TextSelection.collapsed(offset: lastName.value.length)
      );

      yield state.copyWith(
          fullName: fullName.valid ? fullName: FullName.pure(fullName.value),
          lastName: lastName.valid ? lastName: LastName.pure(lastName.value),
          status: Formz.validate([fullName, state.firstName!, lastName])
      );
    }
    else if (event is FullNameUnfocused) {
      final fullName = FullName.dirty(state.fullName!.value);
      yield state.copyWith(
        fullName: fullName,
        status: Formz.validate([fullName, state.firstName!, state.lastName!])
      );
    }
    else if (event is FirstNameUnfocused) {
      final firstName = FirstName.dirty(state.firstName!.value);
      yield state.copyWith(
        firstName: firstName,
        status: Formz.validate([state.fullName!, firstName, state.lastName!])
      );
    }
    else if (event is LastNameUnfocused) {
      final lastName = LastName.dirty(state.lastName!.value);
      yield state.copyWith(
        lastName: lastName,
        status: Formz.validate([state.fullName!, state.firstName!, lastName])
      );
    }
  }
}
