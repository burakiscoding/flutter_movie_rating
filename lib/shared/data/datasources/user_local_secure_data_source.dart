import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class UserLocalSecureDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearTokens();
}

class UserLocalSecureDataSourceImpl extends UserLocalSecureDataSource {
  final FlutterSecureStorage _flutterSecureStorage;

  UserLocalSecureDataSourceImpl({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  @override
  Future<String?> getToken() {
    return _flutterSecureStorage.read(key: 'token');
  }

  @override
  Future<void> saveToken(String token) {
    return _flutterSecureStorage.write(key: 'token', value: token);
  }

  @override
  Future<void> clearTokens() {
    return _flutterSecureStorage.deleteAll();
  }
}
