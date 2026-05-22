import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mindscape/components/auth_field.dart';
import 'package:mindscape/components/auth_form.dart';
import 'package:mindscape/styles/button_styles.dart';

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

  Future<void> onPressed() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    canPress.value = false;

    // TODO: call backend
    await Future.delayed(Duration(seconds: 2));
    
    canPress.value = true;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      title: Text(
        "Register", 
        style: TextStyle(
          color: Colors.white,
          fontSize: screenHeight * 0.1,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SizedBox(
        width: screenWidth * 0.3,
        height: screenHeight * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: screenHeight * 0.05,
          children: [
            AuthForm(
              formKey: formKey, 
              fields: [
                InputField(
                  controller: usernameController, 
                  placeholder: "Username",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username cannot be empty';
                    }
                    return null; 
                  },
                ),
                InputField(
                  controller: passwordController, 
                  placeholder: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null; 
                  }
                ),
              ]
            ),
            ValueListenableBuilder(
              valueListenable: canPress, 
              builder: (context, value, _) => 
                ElevatedButton (
                  onPressed: canPress.value ? onPressed : null, 
                  style: primaryButtonStyle,
                  child: canPress.value ? 
                    Text("Register") :
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2)
                    )
                )
            ),
          ],
        )
      )
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