import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

extension ContextExtensions on BuildContext {
  /// Theme Data
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;

  /// Custom Color Scheme mapping
  AppColorScheme get appColors =>
      AppColorScheme(Theme.of(this).brightness == Brightness.dark);
}
