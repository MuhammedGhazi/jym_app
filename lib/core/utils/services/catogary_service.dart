import 'package:get_storage/get_storage.dart';

class CatogaryService {
  final _box = GetStorage();

  final _key = "categories";

  List<String> categories() {
    List<dynamic> storedList = _box.read(_key) ??
        ["بناء الأجسام", "كرتيه", "جودو", "جمباز", "ملاكمة", "تيكوندو"];
    List<String> lg = storedList.cast<String>();
    return lg;
  }

  updateCategories(List<String> listCategory) {
    _box.write(_key, listCategory);
  }
}
