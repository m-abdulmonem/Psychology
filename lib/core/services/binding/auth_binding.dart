import 'package:get/get.dart';
import '/futures/auth/data/provider/auth_provider.dart';
import '/futures/auth/data/repository/auth_repository.dart';
import '/futures/auth/domain/repository/i_auth_repository.dart';
import '/futures/auth/presentation/manger/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut<IAuthRepository>(() => AuthRepository(provider: Get.find()));
    Get.lazyPut(() => AuthController(authRepository: Get.find()));
  }
}