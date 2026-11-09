import 'package:api_post_three/models/auth_model.dart';
import 'package:api_post_three/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final loginprovider = NotifierProvider<LoginNotifier, AsyncValue<AuthModel?>>(
  () => LoginNotifier(),
);

class LoginNotifier extends Notifier<AsyncValue<AuthModel?>> {
  @override
  AsyncValue<AuthModel?> build() {
    return AsyncData(null);
  }

  Future<void> login({required String email, required String password}) async {
    state = AsyncLoading();

    try {
      final authService = ref.read(authServiceProvider);

      final result = await authService.login(email: email, password: password);

      state = AsyncData(result);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
