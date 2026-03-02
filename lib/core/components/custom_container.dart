import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qunova/core/config/app_color.dart';

Widget CustomContainer({
  required BuildContext context,
  required Widget child,
  EdgeInsets? margin,
  EdgeInsets? padding,
  double? width,
  double? height,
  BorderRadius? borderRadius,
  LinearGradient? linearGradient,
  Color? color,
  BorderSide? border,
  List<BoxShadow>? boxShadow,
  Gradient? gradient,
  BoxShape? shape,
  Alignment? alignment,
  DecorationImage? backgroundImage,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      width: width ?? null,
      height: height ?? null,
      alignment: alignment ?? null,
      decoration: ShapeDecoration(
        color: color ?? null,
        gradient: gradient ?? linearGradient ?? null,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          side: border ?? BorderSide(width: 0, color: color ?? AppStaticColor.gray500,),
        ),
        shadows:
            boxShadow ??
            [
              BoxShadow(
                color: Color(0x28000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
      ),
      child: child,
    ),
  );
}
