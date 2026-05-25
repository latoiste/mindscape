import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mindscape/auth/storage_service.dart';

Future<String?> loginAuth(String username, String password) async {  
  try {
    final url = Uri.parse('http://localhost:3000/auth/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final token = data['token'];

      await StorageService.instance.saveToken(token);

      return null;
    } else {
      final message = data['message'];
      return message;
    }
  } catch (e) {
    return "Please try again";
  }
}

Future<String?> registerAuth(String username, String password) async {  
  try {
    final url = Uri.parse('http://localhost:3000/auth/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final token = data['token'];

      await StorageService.instance.saveToken(token);

      return null;
    } else {
      final message = data['message'];
      return message;
    }
  } catch (e) {
    return "Please try again";
  }
}