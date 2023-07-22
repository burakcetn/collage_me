import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

final textTheme = TextTheme(
    headlineLarge: const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      height: 46 / 40,
    ),
    headlineMedium: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      height: 44 / 36,
    ),
    headlineSmall: TextStyle(
        fontSize: 18.sp, fontWeight: FontWeight.w700, height: 42 / 32),
    titleLarge: TextStyle(
        fontSize: 16.sp, fontWeight: FontWeight.w700, height: 32 / 24),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 8.sp,
      height: 24 / 16,
    ),
    bodyLarge: const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 40, height: 46 / 40),
    bodyMedium: const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 36, height: 44 / 36),
    bodySmall: const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 32, height: 42 / 32),
    labelLarge: const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 24, height: 32 / 24),
    labelMedium: const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 16, height: 24 / 16),
    labelSmall: TextStyle(
        fontWeight: FontWeight.w400, fontSize: 11.sp, height: 16 / 10),
    titleSmall: const TextStyle(
        fontWeight: FontWeight.w700, fontSize: 12, height: 12 / 10));
