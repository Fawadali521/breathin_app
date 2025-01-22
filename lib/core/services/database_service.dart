import 'package:breathin/core/logger_customizations/custom_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseService {
  final log = CustomLogger(className: 'DataBaseService');
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
}
