import 'package:flutter/material.dart';

class TemaApp {
  // ignore: non_constant_identifier_names
  static final ColorScheme EsquemaCores = ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF25D366),
    onPrimary: Colors.green,
    secondary: Colors.red,
    onSecondary: Colors.grey,
    error: Colors.blueAccent,
    onError: Colors.amber,
    background: const Color(0XFF075E54),
    onBackground: Colors.green.shade400,
    surface: Colors.redAccent,
    onSurface: Colors.red,
  );

  static ThemeData themaApp = ThemeData(colorScheme: EsquemaCores);
}
