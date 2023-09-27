// import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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

  Future<int> archiveSub(int id) async {
    var db = await sqlServices.db;
    return db.update("subs", {"archive": 1}, where: "id=?", whereArgs: [id]);
  }

  Future<int> renewalSub(int id, String newDate) async {
    var db = await sqlServices.db;
    var tempNote = await db.rawQuery('SELECT note FROM subs WHERE id = $id ');
    String newNote =
        "${tempNote[0]["note"].toString()}-At ${DateFormat('dd/MM/y').format(DateTime.now())} renewal to $newDate \n";

    // print(newNote);
    return db.update(
      "subs",
      {"upToRecord": newDate, "archive": 0, "note": newNote},
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

  Future<List<Map>> infoCatg() async {
    var db = await sqlServices.db;

    List<Map> infoC = await db.rawQuery('''
          SELECT 
          category,
          COUNT(category) AS count,
          avg(age) AS AvAge,
          avg(weight) AS AvWeight
          FROM subs 
          WHERE archive = 0 
          Group By category
      ''');
    //   for (var e in infoC) {
    //     var transformedMap = e.map((k, v) {
    //   return MapEntry(k,k=="AvAge" ?DateTime.now().year-v :v);
    // });
    // }

    return infoC;
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
