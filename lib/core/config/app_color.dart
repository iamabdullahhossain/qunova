import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? primaryColor;
  final Color? accentColor;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? bodyTextColor;
  final Color? bodyTextSmallColor;
  final Color? titleTextColor;
  final Color? hintTextColor;
  final Color? borderColor;
  final Color? scaffoldBackgroundColor;
  final Color? appBarColor;
  final Color? cardColor;
  final Color? cardColor2;
  final Color? buttonColor2;
  final Color? buttonTextColor2;

  const AppColors({
    required this.primaryColor,
    required this.accentColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.bodyTextColor,
    required this.bodyTextSmallColor,
    required this.titleTextColor,
    required this.hintTextColor,
    required this.borderColor,
    required this.scaffoldBackgroundColor,
    required this.appBarColor,
    required this.cardColor,
    required this.cardColor2,
    required this.buttonColor2,
    required this.buttonTextColor2,
  });

  @override
  AppColors copyWith({
    Color? primaryColor,
    Color? accentColor,
    Color? buttonColor,
    Color? buttonTextColor,
    Color? titleTextColor,
    Color? bodyTextColor,
    Color? bodyTextSmallColor,
    Color? hintTextColor,
    Color? borderColor,
    Color? scaffoldBackgroundColor,
    Color? appBarColor,
    Color? cardColor,
    Color? cardColor2,
    Color? buttonColor2,
    Color? buttonTextColor2,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      bodyTextColor: bodyTextColor ?? this.bodyTextColor,
      bodyTextSmallColor: bodyTextSmallColor ?? this.bodyTextSmallColor,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
      borderColor: borderColor ?? this.borderColor,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      appBarColor: appBarColor ?? this.appBarColor,
      cardColor: cardColor ?? this.cardColor,
      cardColor2: cardColor2 ?? this.cardColor2,
      buttonColor2: buttonColor2 ?? this.buttonColor2,
      buttonTextColor2: buttonTextColor2 ?? this.buttonTextColor2,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t),
      bodyTextColor: Color.lerp(bodyTextColor, other.bodyTextColor, t),
      bodyTextSmallColor: Color.lerp(
        bodyTextSmallColor,
        other.bodyTextSmallColor,
        t,
      ),
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t),
      hintTextColor: Color.lerp(hintTextColor, other.hintTextColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      scaffoldBackgroundColor: Color.lerp(
        scaffoldBackgroundColor,
        other.scaffoldBackgroundColor,
        t,
      ),
      appBarColor: Color.lerp(appBarColor, other.appBarColor, t),
      cardColor: Color.lerp(cardColor, other.cardColor, t),
      cardColor2: Color.lerp(cardColor2, other.cardColor2, t),
      buttonColor2: Color.lerp(buttonColor2, other.buttonColor2, t),
      buttonTextColor2: Color.lerp(buttonTextColor2, other.buttonTextColor2, t),
    );
  }
}

class AppStaticColor {
  ///primary color with shades ---->
  static const Color primaryColor = Color(0xFFFF620A);
  static const Color primaryShade950 = Color(0xFF451005);
  static const Color primaryShade900 = Color(0xFF7F260F);
  static const Color primaryShade800 = Color(0xFF9E2B0E);
  static const Color primaryShade700 = Color(0xFFC73507);
  static const Color primaryShade600 = Color(0xFFF04A06);
  static const Color primaryShade500 = Color(0xFFFF620A);
  static const Color primaryShade400 = Color(0xFFFF8737);
  static const Color primaryShade300 = Color(0xFFFFB370);
  static const Color primaryShade200 = Color(0xFFFFD3A8);
  static const Color primaryShade100 = Color(0xFFFFEBD4);
  static const Color primaryShade50 = Color(0xFFFFF6ED);

  ///Gray color with shades ---->
  static const Color gray950 = Color(0xFF24262D);
  static const Color gray900 = Color(0xFF363A44);
  static const Color gray800 = Color(0xFF3D434F);
  static const Color gray700 = Color(0xFF464D5E);
  static const Color gray600 = Color(0xFF565F73);
  static const Color gray500 = Color(0xFF687387);
  static const Color gray400 = Color(0xFF8A94A6);
  static const Color gray300 = Color(0xFFB3BAC6);
  static const Color gray200 = Color(0xFFD7DAE0);
  static const Color gray100 = Color(0xFFEDEEF1);
  static const Color gray50 = Color(0xFFF6F7F9);

  ///other colors ---->
  static const Color successColor = Color(0xFF4BB543);
  static const Color infoColor = Color(0xFF067BFF);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color errorColor = Color(0xFFF04438);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
}
