import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qunova/feature/home/views/home_screen.dart';
import 'package:qunova/feature/splash_screen/views/splash_screen.dart';

class Routes {
  const Routes._();

  static const splashScreen = '/';
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
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
