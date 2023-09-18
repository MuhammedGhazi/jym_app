import 'package:jym_app/core/utils/services/theme_service.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<ThemeService> {
  CategoryCubit() : super(ThemeService());

  List<String> categories = ThemeService().categories().toList();

  addCatg(String cat) {
    categories.add(cat);
  }

  removeCatg(String value) {
    categories.remove(value);
  }

  // getCategories() {
  //   categories = ThemeService().Categories;
  //   emit(state);
  // }

  setCategories(List<String> ls) {
    ThemeService().updateCategoryKey(ls);
    emit(state);
  }
}
