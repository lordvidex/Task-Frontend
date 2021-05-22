import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  EmailField(this.controller);
  InputBorder border({bool isFocused = false}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: isFocused ? BorderSide(color: Colors.blue) : BorderSide());

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Email address',
          border: border(),
          enabledBorder: border(),
          focusedBorder: border(isFocused: true)),
    );
  }
}
