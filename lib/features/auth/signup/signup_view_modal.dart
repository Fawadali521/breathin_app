import 'package:breathin/core/constants/index.dart';
import 'package:breathin/core/enums/view_state.dart';
import 'package:breathin/core/logger_customizations/custom_logger.dart';
import 'package:breathin/core/models/user_model.dart';
import 'package:breathin/core/services/navigation_services.dart';
import 'package:breathin/core/services/network_service.dart';
import 'package:breathin/core/widgets/custom_snackbar.dart';

import '../../../../core/services/auth_services.dart';
import '../../../../core/view_models/base_view_model.dart';
import '../../../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  final log = CustomLogger(className: "SignUpViewModel");
  UserModel userData = const UserModel();
  String password = "";
  final auth = locator<AuthServices>();
  final NavigationService navigationService = locator<NavigationService>();
  NetworkService networkService = NetworkService();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> signUp() async {
    log.i("all data => ${userData.toJson()}");
    bool isInternetConnected = await networkService.checkInternet();
    if (isInternetConnected) {
      setState(ViewState.busy);
      userData = userData.copyWith(createdAt: Timestamp.now());
      userData = userData.copyWith(updatedAt: Timestamp.now());
      userData = userData.copyWith(imageUrl: "");
      await auth.signupWithEmail(userData, password);
      setState(ViewState.idle);
    } else {
      customSnackBar(message: "Please connect your internet");
    }
  }
}
