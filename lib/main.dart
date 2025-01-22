import 'package:breathin/app/breathin.dart';
import 'package:breathin/core/logger_customizations/custom_logger.dart';
import 'package:breathin/firebase_options.dart';
import 'package:breathin/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final log = CustomLogger(className: 'main');
  log.i('Testing info logs');
  log.w('Testing Warning logs');
  log.d('Testing debug logs');
  log.e('Testing error logs');
  log.t('Testing Trace log');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    Breathin(),
  );
}
