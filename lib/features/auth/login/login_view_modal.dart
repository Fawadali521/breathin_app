import 'package:breathin/core/enums/view_state.dart';
import 'package:breathin/core/exceptions_handler/auth_exception_handler.dart';
import 'package:breathin/core/logger_customizations/custom_logger.dart';
import 'package:breathin/core/models/user_model.dart';
import 'package:breathin/core/routes/routes.dart';
import 'package:breathin/core/services/auth_services.dart';
import 'package:breathin/core/services/database_service.dart';
import 'package:breathin/core/services/navigation_services.dart';
import 'package:breathin/core/services/network_service.dart';
import 'package:breathin/core/view_models/base_view_model.dart';
import 'package:breathin/core/widgets/custom_snackbar.dart';
import 'package:breathin/locator.dart';

class LoginViewModel extends BaseViewModel {
  final log = CustomLogger(className: "LoginViewModel");
  UserModel userData = const UserModel();
  String password = "";
  final auth = locator<AuthServices>();
  final database = locator<DataBaseService>();
  final NavigationService navigationService = locator<NavigationService>();
  NetworkService networkService = NetworkService();
  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
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

  Future<void> signIn() async {
    bool isInternetConnected = await networkService.checkInternet();
    if (isInternetConnected) {
      setState(ViewState.busy);
      final status = await auth.loginWithEmail(userData, password);
      if (status == AuthResultStatus.successful) {
        navigationService.nav.pushReplacementNamed(NamedRoute.home);
      } else {
        final errorMsg = AuthExceptionHandler.generateMessage(status);
        customSnackBar(message: errorMsg);
      }

      setState(ViewState.idle);
    } else {
      customSnackBar(message: "Please connect your internet");
    }
  }
}
