import 'package:flutter/material.dart';
import 'package:mindscape/auth/auth_provider.dart';
import 'package:mindscape/components/auth_field.dart';
import 'package:mindscape/components/auth_form.dart';
import 'package:mindscape/styles/button_styles.dart';
import 'package:mindscape/styles/text_styles.dart';
import 'package:provider/provider.dart';

class AuthDialolg extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> canPress;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Future<bool> Function(String, String) onSubmit;
  final String? authError;

  const AuthDialolg({
    super.key,
    required this.title,
    required this.authError,
    required this.formKey,
    required this.canPress,
    required this.usernameController,
    required this.passwordController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 182, 251),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(
          color: Color(0xFFB92AC3),
          width: 6,
        ),
      ),
      title: Text(
        title, 
        style: TextStyle(
          color: Colors.white,
          fontSize: screenHeight * 0.1,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SizedBox(
        width: screenWidth * 0.3,
        height: screenHeight * 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: screenHeight * 0.05,
          children: [
            AuthForm(
              formKey: formKey, 
              fields: [
                InputField(
                  obscureText: false,
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
                  obscureText: true,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (authError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      authError!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                ValueListenableBuilder(
                  valueListenable: canPress,
                  builder: (context, value, _) => ElevatedButton(
                    onPressed: canPress.value
                      ? () async {
                        canPress.value = false;
                        bool success = await onSubmit(
                          usernameController.text,
                          passwordController.text,
                        );

                        if (!context.mounted) return;

                        if (success) {
                          context.read<AuthProvider>().login();
                          Navigator.of(context).pop();
                        }

                        canPress.value = true;
                      }
                      : null,
                    style: primaryButtonStyle,
                    child: canPress.value
                      ? Text(title, style: menuTextStyle)
                      : const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ),
                ),
              ],
            )
          ],
        )
      )
    );
  }
}