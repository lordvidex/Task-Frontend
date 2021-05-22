import 'package:flutter/material.dart';
import 'package:taskmanagement_frontend/auth/presentation/widgets/email_field_widget.dart';

class PasswordField extends EmailField {
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
