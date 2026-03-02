import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qunova/core/components/custom_container.dart';
import 'package:qunova/gen/assets.gen.dart';

import '../../../core/constants/hive_contants.dart';
import '../../../core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var firstOpen = Hive.box(
      HiveContants.appSettingsBox,
    ).get(HiveContants.firstOpen, defaultValue: true);
    Future.delayed(Duration(seconds: 4), () {
      context.go(
        firstOpen ? Routes.boardingScreen : Routes.homeScreen,
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomContainer(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        context: context,
        linearGradient: LinearGradient(
          begin: Alignment.topRight,
          end: AlignmentGeometry.centerRight,
          colors: [
            Color(0xFFD4ECF3), // Light blue tint
            Colors.white, // Fades to white
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              left: -11,
              child: Image.asset(
                Assets.png.vectorRight.path,
                height: 160.h,
                width: 160.w,
              ),
            ).animate().fadeIn(delay: Duration(seconds: 1)),

            Positioned(
              top: 150,
              bottom: 150,
              left: 150,
              right: 150,
              child: Image.asset(
                Assets.png.logo.path,
                height: 20.h,
                width: 20.w,
              ),
            ).animate().fadeIn(delay: Duration(seconds: 3)),

            Positioned(
              top: -18,
              right: -11,
              child: Image.asset(
                Assets.png.vectorLeft.path,
                height: 110.h,
                width: 110.w,
              ),
            ).animate().fadeIn(delay: Duration(seconds: 1)),
          ],
        ),
      ),
    );
  }
}
