import 'package:jym_app/core/utils/services/sql_services.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';

class SubsRepo {
  SqlServices sqlServices = SqlServices();
  Future<int> add(SubscriberModel subscriberModel) async {
    var db = await sqlServices.db;

    return db.insert("subs", subscriberModel.toJson());
  }

  Future<int> update(SubscriberModel subscriberModel) async {
    var db = await sqlServices.db;
    return db.update("subs", subscriberModel.toJson(),
        where: "id=?", whereArgs: [subscriberModel.id]);
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
      "tall",
      "weight",
      "category",
      "note",
      "dateRecord",
      "upToRecord"
    ]);
    for (var e in map) {
      subscribers.add(SubscriberModel.fromJson(e));
    }
    return subscribers;
  }
}
