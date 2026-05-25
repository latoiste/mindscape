import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mindscape/api/auth.dart';
import 'package:mindscape/dialogs/auth_dialog.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  ValueNotifier<bool> canPress = ValueNotifier(true);
  String? authError;

  Future<bool> onSubmit(String username, String password) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    final errorMsg = await registerAuth(username, password);
    setState(() {
      authError = errorMsg;
    });

    return errorMsg == null;
  }

  @override
  Widget build(BuildContext context) {
    return AuthDialolg(
      title: "Register", 
      authError: authError,
      formKey: formKey, 
      canPress: canPress, 
      usernameController: usernameController, 
      passwordController: passwordController, 
      onSubmit: onSubmit,
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    canPress.dispose();
    
    super.dispose();
  }
}