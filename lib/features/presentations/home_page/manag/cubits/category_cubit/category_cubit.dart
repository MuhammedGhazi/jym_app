import 'package:jym_app/core/utils/services/catogary_service.dart';

import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CatogaryService> {
  CategoryCubit() : super(CatogaryService());

  List<String> categories = CatogaryService().categories().toList();

  addCatg(String cat) {
    categories.add(cat);
    CatogaryService().updateCategories(categories);
    emit(CatogaryService());
  }

  removeCatg(String value) {
    categories.remove(value);
    CatogaryService().updateCategories(categories);
    emit(CatogaryService());
  }
}
