import 'package:flutter/material.dart';
import 'package:mindscape/auth/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  bool loggedIn = false;

  void login() {
    loggedIn = true;
    notifyListeners();
  }

  void logout() {
    loggedIn = false;
    StorageService.instance.deleteToken();
    notifyListeners();
  }
}