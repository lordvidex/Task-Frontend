import 'package:flutter/material.dart';
import 'package:taskmanagement_frontend/auth/presentation/widgets/username_field_widget.dart';

class PasswordField extends UsernameField {
  final TextEditingController controller;
  PasswordField(this.controller) : super(controller);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password',
          border: border(),
          enabledBorder: border(),
          focusedBorder: border(isFocused: true)),
    );
  }
}
