import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_texrt_field/bloc/sync_text_field_bloc.dart';

class LastNameTextField extends StatelessWidget{
  LastNameTextField({Key? key, required this.focusNode, required this.controller});

  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncTextFieldBloc, SyncTextFieldState>(
        builder: (context, state){
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              icon: const Icon(Icons.app_registration),
              labelText: "Last Name",
              helperText: "Please input Last Name",
              errorText: state.lastName!.invalid ? "Last Name must be capitalized" : null,
            ),
            onChanged: (value) {
              context.read<SyncTextFieldBloc>().add(LastNameChanged());
              // context.read<SyncTextFieldBloc>().add(NameDetailHasFocus());
            },
            textInputAction: TextInputAction.next,
          );
        }
    );
  }
}