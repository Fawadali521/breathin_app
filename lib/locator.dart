import 'package:breathin/core/services/navigation_services.dart';
import 'package:get_it/get_it.dart';

import 'core/services/auth_services.dart';
import 'core/services/database_service.dart';
import 'core/services/local_storage_service.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  // locator.registerSingleton(PurchasesService());
  locator.registerSingleton(AuthServices());
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton(DataBaseService());
  // locator.registerLazySingleton(() => FilePickerService());
}
