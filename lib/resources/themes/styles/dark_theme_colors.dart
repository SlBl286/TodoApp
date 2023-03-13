import 'package:flutter/material.dart';
import '/resources/themes/styles/color_styles.dart';

/*
|--------------------------------------------------------------------------
| Dark Theme Colors
|--------------------------------------------------------------------------
*/

class DarkThemeColors implements ColorStyles {
  bool get isDarkTheme => true;
  // general
  Color get background => const Color(0xFF232c33);

  Color get primaryContent => Colors.white;
  Color get primaryAccent => Colors.grey;

  Color get buttonBackgroundPrimary => const Color(0xFF4e5ae8);

  Color get surfaceBackground => Colors.white70;
  Color get surfaceContent => Colors.black;

  // app bar
  Color get appBarBackground => const Color(0xFF4b5e6d);
  Color get appBarPrimaryContent => Colors.white;

  // buttons
  Color get buttonBackground => Colors.white60;
  Color get buttonPrimaryContent => const Color(0xFF232c33);

  // bottom tab bar
  Color get bottomTabBarBackground => const Color(0xFF232c33);

  // bottom tab bar - icons
  Color get bottomTabBarIconSelected => Colors.white70;
  Color get bottomTabBarIconUnselected => Colors.white60;

  // bottom tab bar - label
  Color get bottomTabBarLabelUnselected => Colors.white54;
  Color get bottomTabBarLabelSelected => Colors.white;
}
