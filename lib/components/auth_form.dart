import 'package:flutter/material.dart';
import 'package:mindscape/components/auth_field.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<InputField> fields;

  const AuthForm({
    super.key,
    required this.formKey,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Column(
        spacing: screenHeight * 0.05,
        children: fields,
      )
    );
  }
}