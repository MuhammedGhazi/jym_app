import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();

  final _key = "isDarkMood";
  final _categoryKey = "categories";

  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    _box.write(_key, !_loadThemeFromBox());
  }

  dynamic _loadCategoriesFromBox() {
    try {
      if (_box.read(_categoryKey) == null) {
        return ["GYM", "karati", "Karate", "Judo", "boxing", "taekwondo"];
      } else {
        return _box.read(_categoryKey);
      }
    } catch (e) {
      print(e);
    }
  }

  updateCategories(List<String> listCategory) {
    _box.write(_categoryKey, listCategory);
  }

  List<String> categories() {
    return _loadCategoriesFromBox();
  }
}
