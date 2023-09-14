import 'package:jym_app/core/utils/services/sql_services.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';

class SubsRepo {
  SqlServices sqlServices = SqlServices();
  Future<int> add(SubscriberModel subscriberModel) async {
    var db = await sqlServices.db;
    //debugPrint("subsprepo.add:--${subscriberModel.image!.path}");
    return db.insert("subs", subscriberModel.toJson());
  }

  Future<int> update(SubscriberModel subscriberModel) async {
    var db = await sqlServices.db;
    return db.update("subs", subscriberModel.toJson(),
        where: "id=?", whereArgs: [subscriberModel.id]);
  }

  Future<int> archiveSub(int id) async {
    var db = await sqlServices.db;
    return db.update("subs", {"archive": 1}, where: "id=?", whereArgs: [id]);
  }

  Future<int> renewalSub(int id, String newDate) async {
    var db = await sqlServices.db;
    return db.update(
      "subs",
      {"upToRecord": newDate, "archive": 0},
      where: "id=?",
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    var db = await sqlServices.db;
    return db.delete("subs", where: "id=?", whereArgs: [id]);
  }

  deleteDB() async {
    sqlServices.deletDB();
  }

  Future<List<SubscriberModel>> getSubs() async {
    var db = await sqlServices.db;
    List<SubscriberModel> subscribers = [];
    List<Map<String, dynamic>> map = await db.query("subs", columns: [
      "id",
      "fullName",
      "age",
      "tall",
      "weight",
      "category",
      "note",
      "dateRecord",
      "upToRecord",
      "archive",
      "image",
    ]);
    for (var e in map) {
      subscribers.add(SubscriberModel.fromJson(e));
      // debugPrint("${subscribers.length}");
      // debugPrint("$e");
    }
    return subscribers;
  }

  Future<List<SubscriberModel>> getActiveSubs({int archive = 0}) async {
    var db = await sqlServices.db;
    List<SubscriberModel> subscribers = [];
    List<Map<String, dynamic>> map = await db.query("subs",
        columns: [
          "id",
          "fullName",
          "age",
          "tall",
          "weight",
          "category",
          "note",
          "dateRecord",
          "upToRecord",
          "archive",
          "image",
        ],
        where: "archive=?",
        whereArgs: [archive]);
    for (var e in map) {
      subscribers.add(SubscriberModel.fromJson(e));
    }
    return subscribers;
  }

  Future<List<SubscriberModel>> getCategorySubs(
      {required String category}) async {
    var db = await sqlServices.db;
    String cate =
        category == "All" ? "category != 'All' " : "category = '$category'";
    List<SubscriberModel> subscribers = [];
    List<Map<String, dynamic>> mapcat = await db.rawQuery('''
      SELECT * FROM subs
      WHERE archive = 0 AND
      $cate
''');

    for (var e in mapcat) {
      subscribers.add(SubscriberModel.fromJson(e));
    }
    return subscribers;
  }
}
