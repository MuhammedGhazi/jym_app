import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/core/utils/services/theme_service.dart';

//import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeService().theme);
  ThemeService themeService = ThemeService();
  taggleTheme() {
    if (state == ThemeMode.light) {
      if (themeService.theme == ThemeMode.light) {
        themeService.switchTheme();
      }
      emit(ThemeMode.dark);
    } else {
      if (themeService.theme == ThemeMode.dark) {
        themeService.switchTheme();
      }
      emit(ThemeMode.light);
    }
  }

  bool get isDartMode {
    return state == ThemeMode.dark;
  }
}
