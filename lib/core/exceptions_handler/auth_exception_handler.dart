import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
  weekPassword,
  invalidCredential
}

class AuthExceptionHandler {
  static AuthResultStatus handleException(FirebaseAuthException e) {
    log(e.code);
    AuthResultStatus status;
    switch (e.code) {
      case "invalid-credential":
        status = AuthResultStatus.invalidCredential;
        break;
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "too-many-requests":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "weak-password":
        status = AuthResultStatus.weekPassword;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///

  static String generateMessage(AuthResultStatus? exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidCredential:
        errorMessage = 'Oops! Incorrect email or password. Please try again.';
        break;
      case AuthResultStatus.invalidEmail:
        errorMessage = "Invalid email format. Please check and try again.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Incorrect password. Please try again.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage =
            "No account found with this email. Please sign up or try another email.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage =
            "This account has been disabled. Please contact support for help.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many attempts. Please try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Email and password sign-in is currently unavailable.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "This email is already registered. Please log in or reset your password.";
        break;
      case AuthResultStatus.weekPassword:
        errorMessage = "Weak password. Please use at least 8 characters.";
        break;
      default:
        errorMessage = "Something went wrong. Please try again.";
    }

    return errorMessage;
  }
}
