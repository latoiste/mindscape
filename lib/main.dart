import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindscape/auth/auth_provider.dart';
import 'package:mindscape/main_menu.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
      runApp(
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
          child: const MyApp(),
        ),
      );
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
      home: const MainMenu(),
    );
  }
}

