import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qunova/feature/home/views/home_screen.dart';
import 'package:qunova/feature/splash_screen/views/boarding_screen.dart';
import 'package:qunova/feature/splash_screen/views/splash_screen.dart';

class Routes {
  const Routes._();

  static const splashScreen = '/';
  static const boardingScreen = '/onBoard';
  static const homeScreen = '/home';

}

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final routeObserver = RouteObserver<ModalRoute<void>>();
  static final GoRouter goRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.splashScreen,
    debugLogDiagnostics: kDebugMode,
    observers: [routeObserver],
    routes: [
      GoRoute(
        path: Routes.splashScreen,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: Routes.boardingScreen,
        builder: (context, state) => BoardingScreen(),
      ),
      GoRoute(
        path: Routes.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
