part of 'sync_text_field_bloc.dart';


class SyncTextFieldState {
  const SyncTextFieldState({
    @required this.fullName,
    @required this.firstName,
    @required this.lastName,
    @required this.status,
  });

  final FullName? fullName;
  final FirstName? firstName;
  final LastName? lastName;
  final FormzStatus? status;

  const SyncTextFieldState.initial() :
      this(
        fullName: const FullName.pure(),
        firstName: const FirstName.pure(),
        lastName: const LastName.pure(),
        status: FormzStatus.pure
      );

  SyncTextFieldState copyWith({
    FullName? fullName,
    FirstName? firstName,
    LastName? lastName,
    FormzStatus? status
  }) {
    return SyncTextFieldState(
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status
    );
  }
}
