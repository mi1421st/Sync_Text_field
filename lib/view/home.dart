import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_texrt_field/bloc/sync_text_field_bloc.dart';
import 'package:sync_texrt_field/widget/element/first_name_text_field.dart';
import 'package:sync_texrt_field/widget/element/full_name_text_field.dart';
import 'package:sync_texrt_field/widget/element/last_name_text_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _fullNameFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _fullNameFocus.addListener(() {
      if(_fullNameFocus.hasFocus) {
        // _fullNameController.addListener(() {
        //   // onFullNameChanged();
        //   context.read<SyncTextFieldBloc>().add(FullNameHasFocus());
        // });
        print("full Name Has Focus");
      }
      else{
        context.read<SyncTextFieldBloc>().add(FullNameUnfocused());
      }
    });
    _firstNameFocus.addListener(() {
      if (_firstNameFocus.hasFocus) {
        // _firstNameController.addListener(() {
        //   // onNameDetailChanged();
        //   context.read<SyncTextFieldBloc>().add(NameDetailHasFocus());
        // });
        print("first Name Has Focus");
      }
      else {
        context.read<SyncTextFieldBloc>().add(FirstNameUnfocused());
      }
    });
    _lastNameFocus.addListener(() {
      if (_lastNameFocus.hasFocus) {
        // _lastNameController.addListener(() {
        //   // onNameDetailChanged();
        //   context.read<SyncTextFieldBloc>().add(NameDetailHasFocus());
        // });
        print("last Name Has Focus");
      }
      else {
        context.read<SyncTextFieldBloc>().add(LastNameUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _fullNameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<SyncTextFieldBloc, SyncTextFieldState>(
        builder: (context, state) {
            // _fullNameController.value = TextEditingValue(text: state.fullName!.value);
            // _firstNameController.value = TextEditingValue(text: state.firstName!.value);
            // _lastNameController.value = TextEditingValue(text: state.lastName!.value);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FullNameTextField(focusNode: _fullNameFocus, controller: context.read<SyncTextFieldBloc>().fullNameBlocController),
                FirstNameTextField(focusNode: _firstNameFocus, controller: context.read<SyncTextFieldBloc>().firstNameBlocController),
                LastNameTextField(focusNode: _lastNameFocus, controller: context.read<SyncTextFieldBloc>().lastNameBlocController)
              ],
            ),
          );
        },
        ), // T
    );
  }
}
