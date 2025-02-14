import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  CustomTextField({required this.controller, required this.hintText, this.isPassword = false, required String? Function(dynamic value) validator});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(labelText: hintText),
    );
  }
}
