import 'package:geolocator/geolocator.dart';
import '../models/fire_base_auth_errors_model.dart';

abstract class IAuthRepository {
  Future<FireBaseAuthErrorsModel?> singIn({String? auth, String? password});

  Future<void> singUp(
      {String? email,
      String? name,
      String? password,
      String? username,
      String? type,
      String? status,
      String? phone,
      Position position});

  Future<void> forgetPassword({String? auth});

  Future<FireBaseAuthErrorsModel?> resetPassword({String? auth});

  Future<void> loginWithFacebook();

  Future<void> loginWithGoogle();

  Future<FireBaseAuthErrorsModel?> loginWithPhone({String? phone});

  Future<void> singInAnonymously();

  Future<void> signOut();
}
