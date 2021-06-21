part of 'sync_text_field_bloc.dart';

@immutable
abstract class SyncTextFieldEvent extends Equatable{
  const SyncTextFieldEvent();

  @override
  List<Object> get props => [];
}

class FullNameChanged extends SyncTextFieldEvent{}

class FirstNameChanged extends SyncTextFieldEvent{}

class LastNameChanged extends SyncTextFieldEvent {}


class FullNameUnfocused extends SyncTextFieldEvent {}

class FirstNameUnfocused extends SyncTextFieldEvent {}

class LastNameUnfocused extends SyncTextFieldEvent {}
