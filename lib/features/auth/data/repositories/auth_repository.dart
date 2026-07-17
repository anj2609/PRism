import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/app_constants.dart';

class AuthRepository {
  final FlutterSecureStorage secureStorage;

  AuthRepository({required this.secureStorage});

  Future<String?> getToken() {
    return secureStorage.read(key: AppConstants.secureStorageTokenKey);
  }

  Future<void> saveToken(String token) {
    return secureStorage.write(key: AppConstants.secureStorageTokenKey, value: token);
  }

  Future<void> clearToken() {
    return secureStorage.delete(key: AppConstants.secureStorageTokenKey);
  }
}
