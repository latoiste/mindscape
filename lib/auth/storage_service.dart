import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  StorageService._internal();

  static final StorageService instance = StorageService._internal();
  static final _keyToken = 'auth_key';

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveToken(String token) => _storage.write(key: _keyToken, value: token);

  Future<String?> getToken() => _storage.read(key: _keyToken);

  Future<void> deleteToken() => _storage.delete(key: _keyToken);
}