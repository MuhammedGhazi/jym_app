import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/core/utils/services/theme_service.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  ThemeService themeService = ThemeService();
  changeTheme() {
    themeService.switchTheme();
  }
}
