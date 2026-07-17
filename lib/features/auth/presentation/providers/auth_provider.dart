import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository.dart';
import '../../../../core/di/providers.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? username;

  const AuthState({this.status = AuthStatus.unknown, this.username});

  AuthState copyWith({AuthStatus? status, String? username}) {
    return AuthState(
      status: status ?? this.status,
      username: username ?? this.username,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(const AuthState()) {
    checkStatus();
  }

  Future<void> checkStatus() async {
    final token = await repository.getToken();
    state = state.copyWith(
      status: token != null ? AuthStatus.authenticated : AuthStatus.unauthenticated,
    );
  }

  Future<void> loginWithToken(String token) async {
    await repository.saveToken(token);
    state = state.copyWith(status: AuthStatus.authenticated);
  }

  Future<void> logout() async {
    await repository.clearToken();
    state = state.copyWith(status: AuthStatus.unauthenticated, username: null);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(secureStorage: ref.watch(secureStorageProvider));
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
