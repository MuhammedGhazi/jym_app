import 'package:jym_app/core/utils/services/theme_service.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<List<String>> {
  CategoryCubit() : super(ThemeService().categoryKey);
  var categories = ThemeService().categoryKey;
  addCatg(String cat) {
    categories.add(cat);
  }

  removeCatg(String value) {
    categories.remove(value);
  }

  getCategories() {
    categories = ThemeService().categoryKey;
    emit(state);
  }

  setCategories(List<String> ls) {
    ThemeService().categoryKey = ls;
    emit(state);
  }
}
