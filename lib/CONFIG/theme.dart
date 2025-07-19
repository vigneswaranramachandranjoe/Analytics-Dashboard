import 'package:flutter/material.dart';
import 'package:web_dashboard/CONSTANT/app_colors.dart';

final ThemeData spatialCortexTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF14E59E), // Brand Green
  scaffoldBackgroundColor: const Color(0xFF0B0B2B), // Dark BG



  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF14E59E),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold
    ),
    elevation: 0,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Color(0xFF14E59E),
  ),




  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF14E59E),
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

);
