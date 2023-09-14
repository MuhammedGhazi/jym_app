import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = "isDarkMood";

  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    _box.write(_key, !_loadThemeFromBox());
  }

  List<String> _loadCategoriesFromBox() =>
      _box.read(_categoryKey) ??
      ["GYM", "karati", "Karate", "Judo", "boxing", "taekwondo"];

  final _categoryKey = "categories";
  set categoryKey(List<String> listCategory) {
    _box.write(_categoryKey, listCategory);
  }

  List<String> get categoryKey {
    return _loadCategoriesFromBox();
  }
}
