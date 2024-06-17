import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;

  CustomInputField({
    required this.controller,
    required this.labelText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      obscureText: isPassword,
    );
  }
}
