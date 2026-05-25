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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main_menu.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          spacing: screenHeight * 0.05,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/title.png",
              height: screenHeight * 0.25,
              fit: BoxFit.cover,
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
