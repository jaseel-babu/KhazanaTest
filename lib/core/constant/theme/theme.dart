import 'package:flutter/material.dart';
import 'package:khazana_fintech_task/core/constant/theme/app_color.dart';

class AppTheme {
  static OutlineInputBorder _border([Color color = AppColor.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static ThemeData getTheme() {
    return ThemeData(
      dividerTheme: const DividerThemeData(color: Colors.transparent),
      scaffoldBackgroundColor: AppColor.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: _border(),
        border: _border(),
        focusedBorder: _border(AppColor.backgroundColor),
        contentPadding: const EdgeInsets.all(27),
        errorBorder: _border(AppColor.errorColor),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.backgroundColor,
      ),
    );
  }
}
