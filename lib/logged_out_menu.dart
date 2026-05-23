import 'package:flutter/material.dart';
import 'package:mindscape/dialogs/login_dialog.dart';
import 'package:mindscape/dialogs/resgiter_dialog.dart';
import 'package:mindscape/styles/button_styles.dart';

class LoggedOutMenu extends StatelessWidget {
  const LoggedOutMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.3,
      child: Column(
        spacing: screenHeight * 0.025,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            style: primaryButtonStyle,
            child: const Text("Login"),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => LoginDialog(),
              );
            }
          ),
          ElevatedButton(
            style: primaryButtonStyle,
            child: const Text("Register"),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => RegisterDialog(),
              );
            }
          ),
          ElevatedButton(
            style: primaryButtonStyle,
            child: const Text("Quit"),
            onPressed: () {}
          ),
        ]
      ),
    );
  }
}