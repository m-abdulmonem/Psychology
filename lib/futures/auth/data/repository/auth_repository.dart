import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../domain/models/fire_base_auth_errors_model.dart';
import '../provider/auth_provider.dart';
import '../../domain/repository/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final AuthProvider provider;

  AuthRepository({required this.provider});

  @override
  Future<FireBaseAuthErrorsModel?> singIn(
      {String? auth, String? password}) async {
    final response = (!GetUtils.isEmail(auth!))
        ? await provider.signInWithUsername(username: auth, password: password)
        : await provider.signIn(email: auth, password: password);

    _redirect(response);
    if (response != null) Get.snackbar("error".tr, response.message?.tr ?? "");
    return null;
  }

  @override
  Future<void> loginWithFacebook() async =>
      _redirect(await provider.signInWithFacebook());

  @override
  Future<void> loginWithGoogle() async =>
      _redirect(await provider.signInWithGoogle());

  @override
  Future<void> forgetPassword({String? auth}) async =>
      _redirect(await provider.forgetPassword(email: auth),
          route: "auth/login");

  @override
  Future<FireBaseAuthErrorsModel?> resetPassword({String? auth}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> singUp(
          {String? email,
          String? name,
          String? password,
          String? type,
          String? username,
          String? status,
          String? phone,
          Position? position}) async =>
      _redirect(await provider.signUp(
          email: email,
          password: password,
          username: username,
          name: name,
          type: type,
          phone: phone,
          position: position),type: type);

  void _redirect(response, {String route = "main",String? type}) =>
    (response == null)
        ? Get.offAllNamed(route,arguments: type != null ? {"type": type} : {})
        : Get.snackbar("error".tr, response.message?.toString().tr ?? "");


  @override
  Future<FireBaseAuthErrorsModel?> loginWithPhone({String? phone}) async {
    await provider.signInWithPhone(number: phone);
    return null;
  }

  @override
  Future<void> singInAnonymously() async {
    await provider.signInAnonymously();

    Get.offAllNamed("main");
  }

  @override
  Future<void> signOut() async {
    await provider.signOut();
    Get.offAllNamed("auth");
  }
}
