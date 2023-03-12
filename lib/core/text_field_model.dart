import 'package:flutter/cupertino.dart';

class TextFieldModel {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String placeHolder;
  final String? initialValue;
  final String? Function(String?)? validator;
  final bool obscureText;

  TextFieldModel({
    required this.textEditingController,
    required this.focusNode,
    required this.placeHolder,
    this.initialValue,
    required this.validator,
    this.obscureText = false,
  });
}
