// ignore_for_file: avoid_print

import 'package:breathin/core/constants/collection_constant.dart';
import 'package:breathin/core/exceptions_handler/auth_exception_handler.dart';
import 'package:breathin/core/logger_customizations/custom_logger.dart';
import 'package:breathin/core/models/user_model.dart';
import 'package:breathin/core/responses/base_responses/base_response.dart';
import 'package:breathin/core/routes/routes.dart';
import 'package:breathin/core/services/database_service.dart';
import 'package:breathin/core/services/navigation_services.dart';
import 'package:breathin/core/widgets/custom_snackbar.dart';
import 'package:breathin/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
/// [AuthServices] class contains all authentication related logic with following
///

class AuthServices {
  final log = CustomLogger(className: 'AuthServices');
  final NavigationService navigationService = locator<NavigationService>();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  AuthResultStatus? _status;
  BaseResponse baseResponse = BaseResponse();
  final database = DataBaseService();
  UserModel? userData;

  //
  // delete account
  //
  Future<bool> deleteAccount() async {
    try {
      await _auth.currentUser!.delete();
      log.i("delete accout true ");
      return true;
    } on FirebaseAuthException catch (e) {
      log.d("delete account errr $e");
      return false;
    } catch (e) {
      log.e('Error deleting account: $e');
      return false;
    }
  }

  signout() async {
    await _auth.signOut();
    navigationService.nav.pushReplacementNamed(NamedRoute.signIn);
    userData = null;
  }

  ///
  /// [signupWithGmail]:
  ///
  signupWithEmail(UserModel body, String password) async {
    try {
      final status = await createAccount(
        email: body.email!,
        pass: password,
      );
      if (status == AuthResultStatus.successful) {
        User? user = _auth.currentUser;
        if (user != null) {
          body = body.copyWith(uid: user.uid);
          body = body.copyWith(email: user.email);
          baseResponse = await addUser(body);
          if (baseResponse.success == true) {
            bool dataGet = await getUser(body.uid.toString());
            if (dataGet) {
              navigationService.nav.pushReplacementNamed(NamedRoute.home);
            } else {
              customSnackBar(
                message: "Something went wrong! Try Again Later",
              );
            }
          } else {
            await _auth.currentUser!.delete().then((value) {
              customSnackBar(
                message: "Something went wrong! Try Again Later",
              );
            });
          }
        }
      } else {
        final errorMsg = AuthExceptionHandler.generateMessage(status);
        customSnackBar(message: errorMsg);
      }
    } catch (e) {
      customSnackBar(message: "Something went wrong! Try Again Later");
    }
  }

  ///
  /// [signinWithEmail]:
  ///
  Future<AuthResultStatus?> loginWithEmail(
      UserModel userData, String password) async {
    try {
      final authResult = await _auth
          .signInWithEmailAndPassword(
        email: userData.email!,
        password: password,
      )
          .timeout(const Duration(seconds: 30), onTimeout: () {
        throw ();
      });
      if (authResult.user != null) {
        bool getDate = await getUser(authResult.user!.uid);
        if (getDate) {
          _status = AuthResultStatus.successful;
        }
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    } catch (e) {
      customSnackBar(message: "Something went wrong! Try Again Later");
    }
    return _status;
  }

  //
  // user data add in firestore
  //
  addUser(UserModel body) async {
    if (body.uid != null && body.email != null && body.name != null) {
      try {
        print("show data 2  ${body.toJson()}");
        await _db
            .collection(CollectionConstant.usersCollection)
            .doc(body.uid)
            .set(body.toJson());
        baseResponse.error = "";
        baseResponse.success = true;
        return baseResponse;
      } catch (e) {
        baseResponse.error = "Something went wrong! Try Again Later";
        baseResponse.success = false;
        return baseResponse;
      }
    } else {
      baseResponse.error = "Something went wrong! Try Again Later";
      baseResponse.success = false;
      return baseResponse;
    }
  }

  //
  // user data get in firestore
  //
  getUser(String id) async {
    userData = const UserModel();
    try {
      final snapshot = await _db
          .collection(CollectionConstant.usersCollection)
          .doc(id)
          .get();
      if (snapshot.exists) {
        userData = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
        log.d(userData!.createdAt!.toDate());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//! Create Account
  Future<AuthResultStatus?> createAccount({
    required String email,
    required String pass,
  }) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    } catch (e) {
      customSnackBar(message: e.toString());
    }
    return _status;
  }
}
