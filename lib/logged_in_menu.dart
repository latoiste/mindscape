import 'package:flutter/material.dart';
import 'package:mindscape/api/score.dart';
import 'package:mindscape/auth/auth_provider.dart';
import 'package:mindscape/game/mindscape.dart';
import 'package:mindscape/styles/button_styles.dart';
import 'package:mindscape/styles/text_styles.dart';
import 'package:provider/provider.dart';

class LoggedInMenu extends StatelessWidget {
  const LoggedInMenu({super.key});

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
          Center(
            child: FutureBuilder(
              future: getHighscore(), 
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final (success, highscore) = snapshot.data!;

                if (!success) {
                  return Text(
                    "Highscore: N/A",
                    style: menuTextStyle.copyWith(
                      fontSize: 24,
                    ),
                  );
                }

                return Text(
                  "Highscore: $highscore",
                  style: menuTextStyle.copyWith(
                    fontSize: 24,
                  ),
                );
              }
            ),
          ),
          ElevatedButton(
            style: primaryButtonStyle,
            child: Text(
              "Play",
              style: menuTextStyle,
            ),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => Mindscape()),
              );
            }
          ),
          ElevatedButton(
            style: primaryButtonStyle,
            child: Text(
              "Logout",
              style: menuTextStyle,
            ),
            onPressed: () {
              context.read<AuthProvider>().logout();
            }
          ),
          ElevatedButton(
            style: primaryButtonStyle,
            child: Text(
              "Quit",
              style: menuTextStyle,
            ),
            onPressed: () {}
          ),
        ]
      ),
    );
  }
}