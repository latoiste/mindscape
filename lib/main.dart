import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindscape/main_menu.dart';
import 'package:mindscape/styles/button_styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
      runApp(const MyApp());  
    }
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindscape',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: GoogleFonts.fredoka().fontFamily,

        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: primaryButtonStyle,
        ),
      ),
      home: const MainMenu(),
    );
  }
}

