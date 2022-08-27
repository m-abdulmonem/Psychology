import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:psychology/core/services/custom_widgets.dart';
import '../../domain/models/fire_base_auth_errors_model.dart';
import '../../domain/models/user_model.dart';
import '/core/services/db/fire_store_db.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '/core/services/db/get_storage_keys.dart';

enum AccountStatus { active, disabled }

abstract class IAuthProvider {
  Future<FireBaseAuthErrorsModel?> signIn({String? email, String? password});
  Future<FireBaseAuthErrorsModel?> forgetPassword({String? email});
  Future<FireBaseAuthErrorsModel?> signInWithUsername(
      {String? username, String? password});
  Future<FireBaseAuthErrorsModel?> signInWithGoogle();
  Future<FireBaseAuthErrorsModel?> signInWithFacebook();
  Future<FireBaseAuthErrorsModel?> signUp(
      {String? email,
      String? phone,
      String? name,
      String? type,
      String? status,
      Position? position,
      String? username,
      String? password});
  Future<ConfirmationResult?> signInWithPhone({String? number, String? code});
  Future<void> signInAnonymously();
  Future<void> signOut();
}

class AuthProvider implements IAuthProvider {
  final _store = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = GetStorage();

  @override
  Future<FireBaseAuthErrorsModel?> signIn(
      {String? email, String? password}) async {
    try {
      final snap = await _store
          .collection(FireStoreDb.users)
          .where('email', isEqualTo: email)
          .get();

      if (snap.docs[0]['status'] == AccountStatus.disabled.toString()) {
        return FireBaseAuthErrorsModel(
            code: "user-disabled",
            message: "The user account has been disabled by an administrator.");
      }
      var user =  await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      _save(user, "password",snap.docs[0]['type']);

      return null;
    } on FirebaseAuthException catch (e) {
      return FireBaseAuthErrorsModel(code: e.code, message: e.message);
    }
  }

  @override
  Future<FireBaseAuthErrorsModel?> signInWithUsername(
      {String? username, String? password}) async {
    try {
      final snap = await _store
          .collection(FireStoreDb.users)
          .where('username', isEqualTo: username)
          .get();

      /// no data found
      if (snap.size < 1) {
        return FireBaseAuthErrorsModel(
            code: "not-found-auth", message: "Username not found");
      }

      if (snap.docs[0]['status'] == AccountStatus.disabled.toString()) {
        return FireBaseAuthErrorsModel(
            code: "user-disabled",
            message: "The user account has been disabled by an administrator.");
      }
      var user = await _auth.signInWithEmailAndPassword(
          email: snap.docs[0]['email'], password: password!);
      _save(user,"password",snap.docs[0]['type']);
      return null;
    } on FirebaseAuthException catch (e) {
      return FireBaseAuthErrorsModel(code: e.code, message: e.message);
    }
  }

  @override
  Future<ConfirmationResult?> signInWithPhone(
      {String? number, String? code}) async {
    try {
      if (kIsWeb) {
        ConfirmationResult confirmationResult =
            await _auth.signInWithPhoneNumber(
                number ?? '+44 7123 123 456',
                RecaptchaVerifier(
                  container: 'recaptcha',
                  size: RecaptchaVerifierSize.compact,
                  theme: RecaptchaVerifierTheme.dark,
                  onSuccess: () => print('reCAPTCHA Completed!'),
                  onError: (FirebaseAuthException error) => print(error),
                  onExpired: () => print('reCAPTCHA Expired!'),
                ));
        await confirmationResult.confirm(code ?? "123456");
        return confirmationResult;
      }
      var query;
      await _auth.verifyPhoneNumber(
        phoneNumber: number ?? '+44 7123 123 456',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          if (kDebugMode) {
            print("verifyPhoneNumber -verificationCompleted");
          }
          // Sign the user in (or link) with the auto-generated credential
          query = await _auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (kDebugMode) {
            print("verifyPhoneNumber -codeAutoRetrievalTimeout");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print("verifyPhoneNumber -verificationFailed");
          }
          if (e.code == 'invalid-phone-number') {
            if (kDebugMode) {
              print('The provided phone number is not valid.');
            }
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          String smsCode = 'xxxx';
          if (kDebugMode) {
            print("verifyPhoneNumber -codeSent");
          }
          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _auth.signInWithCredential(credential);
        },
      );
      return query;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("signInWithPhone ${e.code} . ${e.message}");
      }
    }
    return null;
  }

  @override
  Future<FireBaseAuthErrorsModel?> signUp(
      {String? email,
      String? name,
      String? phone,
      String? username,
      String? type,
      String? status = "active",
      String? password,
      Position? position}) async {
    try {
      final query = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      String? city = await getAddress(position);

      _auth.currentUser?.updateDisplayName(name);

      FirebaseFirestore.instance
          .collection(FireStoreDb.users)
          .doc(query.user?.uid)
          .set({
        "username": username,
        "email": email,
        "phone": phone,
        "name": name,
        "uid": query.user?.uid,
        "type": type,
        "status": status,
        "location": GeoPoint(position!.latitude, position.longitude),
        "city": city
      });

      _save(query, "password",type!);
      return null;
    } on FirebaseAuthException catch (e) {
      return FireBaseAuthErrorsModel(code: e.code, message: e.message);
    }
  }

  @override
  Future<FireBaseAuthErrorsModel?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      _save(await _auth.signInWithCredential(credential), "google","client");
      return null;
    } on FirebaseAuthException catch (e) {
      return FireBaseAuthErrorsModel(message: e.message, code: e.code);
    }
  }

  @override
  Future<FireBaseAuthErrorsModel?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      _save(_auth.signInWithCredential(facebookAuthCredential), "facebook","client");
      return null;
    } on FirebaseAuthException catch (e) {
      return FireBaseAuthErrorsModel(message: e.message, code: e.code);
    }
  }

  void _save(user,String provider,String type) {
    _storage.write(GetStorageKeys.isLoggedInKey, true);
    _storage.write(GetStorageKeys.profileKey,
        UserModel.fromJson(user, provider).toJson());
    _storage.write(GetStorageKeys.accountTypeKey,type);
  }

  @override
  Future<FireBaseAuthErrorsModel?> forgetPassword({String? email}) async {
    try {
      if (!GetUtils.isEmail(email!)) {
        final snap = await _store
            .collection(FireStoreDb.users)
            .where('username', isEqualTo: email)
            .get();
        if (snap.size > 1) {
          await _auth.sendPasswordResetEmail(email: snap.docs[0]['email']);
        }

        return null;
      }

      await _auth.sendPasswordResetEmail(email: email);

      return null;
    } on FirebaseAuthException catch (e) {
      return FireBaseAuthErrorsModel(message: e.message, code: e.code);
    }
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      final user = await _auth.signInAnonymously();
      _save(user, "anonymously","client");
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("auth_provider.dart-signInAnonymously : ${e.message}");
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (_storage.read(GetStorageKeys.isLoggedInKey) &&
          _storage.hasData(GetStorageKeys.profileKey)) {
        switch (_storage.read(GetStorageKeys.profileKey)) {
          case "facebook":
            await FacebookAuth.instance.logOut();
            break;
          case "google":
            await GoogleSignIn().signOut();
            break;
        }
        await _auth.signOut();
        await _storage.erase();
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("auth_provider.dart-signOut : ${e.message}");
      }
    }
  }
}
