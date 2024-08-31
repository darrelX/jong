import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

extension ThemeDataX on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension MediaQueryX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get width => screenSize.width;
  double get height => screenSize.height;

  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension AppLocalizationX on BuildContext {
  AppLocalizations get appLocalization => AppLocalizations.of(this)!;
}
