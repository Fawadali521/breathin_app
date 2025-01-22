import 'package:breathin/core/constants/index.dart';
import 'package:breathin/core/routes/routes.dart';
import 'package:breathin/core/services/navigation_services.dart';
import 'package:breathin/locator.dart';

import '../features/home/home_view_modal.dart';

class Breathin extends StatelessWidget {
  Breathin({super.key});
  final NavigationService navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(430, 932),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BottomNavigationViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigationService.rootNavKey,
          title: 'Breathin App',
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: NamedRoute.splash,
        ),
      ),
    );
  }
}
