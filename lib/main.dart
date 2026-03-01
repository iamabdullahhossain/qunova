import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qunova/core/constants/hive_contants.dart';
import 'package:qunova/core/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveContants.appSettingsBox);
  await Hive.openBox(HiveContants.authBox);
  await Hive.openBox(HiveContants.userBox);

  runApp(
    ProviderScope(
      observers: [],
      child: DevicePreview(enabled: false, builder: (context) => MyApp()),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return ValueListenableBuilder(
          valueListenable: Hive.box(HiveContants.appSettingsBox).listenable(),

          builder: (context, appSettingsBox, _) {
            final isDark =
                appSettingsBox.get(
                      HiveContants.isDarkTheme,
                      defaultValue: false,
                    )
                    as bool;
            return MaterialApp.router(
              title: 'Qunova',
              //  theme: getAppTheme(isDarkTheme: false),
              showPerformanceOverlay: false,
              debugShowCheckedModeBanner: false,
              //  darkTheme: getAppTheme(isDarkTheme: true),
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              routerConfig: AppRouter.goRouter,
            );
          },
        );
      },
    );
  }
}
