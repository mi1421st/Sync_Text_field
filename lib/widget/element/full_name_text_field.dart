import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_texrt_field/bloc/sync_text_field_bloc.dart';

class FullNameTextField extends StatelessWidget{
  FullNameTextField({Key? key, required this.focusNode, required this.controller});

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
              labelText: "Full Name",
              helperText: "Please input Full Name",
              errorText: state.fullName!.invalid ? "Full Name must be capitalized" : null,
            ),
            onChanged: (value) {
              context.read<SyncTextFieldBloc>().add(FullNameChanged());
              TextSelection.collapsed(offset: controller.text.length);
              // context.read<SyncTextFieldBloc>().add(FullNameHasFocus());
            },
            textInputAction: TextInputAction.next,
          );
        }
    );
  }
}