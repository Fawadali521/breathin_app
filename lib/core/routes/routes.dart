import 'package:breathin/features/auth/login/login_screen.dart';
import 'package:breathin/features/auth/signup/signup_screen.dart';
import 'package:breathin/features/home/home_screen.dart';
import 'package:breathin/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NamedRoute.splash:
        return MaterialPageRoute<void>(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case NamedRoute.signUp:
        return MaterialPageRoute<void>(
          builder: (context) => SignupScreen(),
          settings: settings,
        );
      case NamedRoute.home:
        return MaterialPageRoute<void>(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );
      case NamedRoute.signIn:
        return MaterialPageRoute<void>(
          builder: (context) => LoginScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => UndefinedView(name: settings.name),
          settings: settings,
        );
    }
  }
}

class UndefinedView extends StatelessWidget {
  final String? name;
  const UndefinedView({
    this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Something went wrong for $name'),
      ),
    );
  }
}

class NamedRoute {
  NamedRoute._();

  static const String splash = '/';
  static const String home = '/home';
  static const String signUp = '/SignUp';
  static const String signIn = '/SignIn';
}
