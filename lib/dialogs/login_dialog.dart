import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mindscape/api/auth.dart';
import 'package:mindscape/dialogs/auth_dialog.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  ValueNotifier<bool> canPress = ValueNotifier(true);
  String? authError;

  Future<bool> onSubmit(String username, String password) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    final errorMsg = await loginAuth(username, password);
    setState(() {
      authError = errorMsg;
    });

    return errorMsg == null;
  }

  @override
  Widget build(BuildContext context) {
    return AuthDialolg(
      title: "Login", 
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