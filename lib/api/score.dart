import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindscape/auth/storage_service.dart';

Future<bool> updateHighscore(int highscore) async {
  print("helo");
  final String? token = await StorageService.instance.getToken();

  if (token == null) return false;
   
  final Uri url = Uri.parse('http://localhost:3000/score');

  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', 
      },
      body: jsonEncode({
        'highscore': highscore,
      }),
    );

    print("hai");
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

Future<(bool, int)> getHighscore() async {
  final String? token = await StorageService.instance.getToken();

  if (token == null) return (false, 0);
   
  final Uri url = Uri.parse('http://localhost:3000/score');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', 
      },
    );

    if (response.statusCode == 200) {
      String rawBody = response.body; 
    
      var decodedJson = jsonDecode(rawBody);

      int highscore = decodedJson['highscore'];

      return (true, highscore);
    } else {
      return (false, 0);
    }

  } catch (e) {
    return (false, 0);
  }
}