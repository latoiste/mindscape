import 'package:flutter/material.dart';
import 'package:mindscape/auth/auth_provider.dart';
import 'package:mindscape/logged_in_menu.dart';
import 'package:mindscape/logged_out_menu.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final auth = context.watch<AuthProvider>();

    return Scaffold (
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          spacing: 50,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mindscape", 
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.15,
                fontWeight: FontWeight.w700,
              ),
            ),
            auth.loggedIn ?
            LoggedInMenu() :
            LoggedOutMenu()
          ],
        ),
      ),
    );
  }
}
