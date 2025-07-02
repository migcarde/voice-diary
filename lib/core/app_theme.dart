import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData mainTheme() => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(
            0xFFdfad8b,
          ),
          dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
        ),
      );
}
