import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final String? Function(String?) validator;
  final bool obscureText;

  const InputField({
    super.key, 
    required this.controller, 
    required this.placeholder,
    required this.validator,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: placeholder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
        ),
        validator: validator
      ),
    );
  }
}