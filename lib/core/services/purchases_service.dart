import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesService {
  // final _entitlementID = 'premium';

  final String _appleApiKey = '';
  final String _googleApiKey = 'goog_YrJDXcwTbGotbHNJzCRZrmtjsyt';
  final List<String> _iosIdentifiers = ['monthly_complete_v2'];
  final List<String> _androidIdentifiers = [
    'yearly_premium',
    'monthly_premium'
  ];
  late PurchasesConfiguration _configuration;

  init() async {
    try {
      await Purchases.setLogLevel(LogLevel.debug);
      if (Platform.isIOS) {
        _configuration = PurchasesConfiguration(_appleApiKey);
      } else {
        _configuration = PurchasesConfiguration(_googleApiKey);
      }
      await Purchases.configure(_configuration);
      return this;
    } on Exception {
      rethrow;
    }
  }

  Future<List<StoreProduct>> fetchProducts() async {
    List<String> productIdentifiers =
        Platform.isIOS ? _iosIdentifiers : _androidIdentifiers;
    try {
      return await Purchases.getProducts(productIdentifiers);
      // return products;
    } on Exception {
      rethrow;
    }
  }

  // Future<void> fetchOfferings() async {
  //   await Purchases.getOfferings().then((value) {
  //     for (final entry in value.all.entries) {
  //       log(entry.value.availablePackages);
  //     }
  //   });
  // }

  Future<CustomerInfo> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } on Exception {
      rethrow;
    }
  }

  Future<CustomerInfo> purchaseProduct(StoreProduct product) async {
    try {
      return await Purchases.purchaseStoreProduct(product);
    } on Exception {
      rethrow;
    }
  }

  Future<CustomerInfo> restorePurchases() async {
    try {
      return await Purchases.restorePurchases();
    } on Exception {
      rethrow;
    }
  }

  Future<LogInResult> login(String userId) async {
    try {
      return await Purchases.logIn(userId);
    } on Exception {
      rethrow;
    }
  }

  Future<CustomerInfo> logout() async {
    try {
      return await Purchases.logOut();
    } on Exception {
      rethrow;
    }
  }
}
