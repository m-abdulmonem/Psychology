import 'package:get_storage/get_storage.dart';

class GetStorageKeys{

  static const String profileKey = "KEY_USER_PROFILE_DATA";
  static const String accountTypeKey = "KEY_ACCOUNT_TYPE";
  static const String isLoggedInKey = "KEY_IS_LOGGED_IN";
  static const String isOnBoardingKey = "KEY_IS_ON_BOARDING_FINISHED";



  void get removeKeys => GetStorage().erase();

}