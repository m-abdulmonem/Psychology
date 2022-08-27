import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '/core/services/custom_widgets.dart';
import '../../domain/repository/i_auth_repository.dart';
import 'validator.dart';

class AuthController extends GetxController with Validator {
  final GlobalKey<FormState> authForm = GlobalKey<FormState>();
  final IAuthRepository authRepository;
  Position? _position;
  String auth = "",
      email = "",
      password = "",
      name = "",
      username = "",
      phone = "",
      type = "client";

  AuthController({required this.authRepository});

  @override
  void onInit() async {
    _position = await determinePosition();
    super.onInit();
  }

  get form => authForm.currentState;

  void signIn() async {
    if (form!.validate()) {
      form.save();
      await authRepository.singIn(auth: auth, password: password);
    }
  }

  void signUp() async {
    if (form!.validate()) {
      form.save();
      await authRepository.singUp(
        email: email,
        password: password,
        name: name,
        position: _position!,
        type: type,
        username: username,
        phone: phone,
      );
    }
  }

  void forgetPassword() async {
    if (form!.validate()) {
      form.save();
      await authRepository.forgetPassword(auth: auth);
    }
  }

  void loginWithPhone() async {
    if (form!.validate()) {
      form.save();
      await authRepository.loginWithPhone(phone: auth);
    }
  }

  void signInWithFacebook() async => await authRepository.loginWithFacebook();

  void signInWithGoogle() async => await authRepository.loginWithGoogle();

  void signInAnon() async => await authRepository.singInAnonymously();

  void signOut() async => await authRepository.signOut();

  void selectType(val){
    type = val;
    update();
  }

}
