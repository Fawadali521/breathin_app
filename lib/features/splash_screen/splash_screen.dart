import 'package:breathin/core/constants/text_styles.dart';
import 'package:breathin/core/logger_customizations/custom_logger.dart';
import 'package:breathin/core/routes/routes.dart';
import 'package:breathin/core/services/auth_services.dart';
import 'package:breathin/core/services/local_storage_service.dart';
import 'package:breathin/core/services/navigation_services.dart';
import 'package:breathin/core/services/network_service.dart';
import 'package:breathin/core/widgets/custom_snackbar.dart';
import 'package:breathin/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final log = CustomLogger(className: 'SplashScreen');
  final auth = locator<AuthServices>();
  final localStorage = locator<LocalStorageService>();
  final NavigationService navigationService = locator<NavigationService>();
  // final purchasesService = locator<PurchasesService>();
  // final databaseService = locator<DatabaseService>();
  @override
  void initState() {
    super.initState();
    _initialSetup(context);
  }

  _initialSetup(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    await localStorage.init();
    final connectivityResult = await NetworkService().checkInternet();
    log.i("check internet connection ==>$connectivityResult");
    if (!connectivityResult) {
      customSnackBar(
        message: 'Please check your internate connection',
      );
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      bool getDate = await auth.getUser(user.uid);
      if (getDate) {
        navigationService.nav.pushReplacementNamed(NamedRoute.home);
      } else {
        customSnackBar(
          message: 'The session expires please login again',
        );
        auth.signout();
        navigationService.nav.pushReplacementNamed(NamedRoute.signIn);
      }
    } else {
      navigationService.nav.pushReplacementNamed(NamedRoute.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Breathin App",
          style: kTextStyle3,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
