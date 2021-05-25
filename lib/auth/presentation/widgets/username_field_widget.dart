import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  UsernameField(this.controller);
  InputBorder border({bool isFocused = false}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: isFocused ? BorderSide(color: Colors.blue) : BorderSide());

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: 'Username',
          border: border(),
          enabledBorder: border(),
          focusedBorder: border(isFocused: true)),
    );
  }
}
