import 'dart:io';

import 'package:flutter/material.dart';

class SubscriberModel {
  int? id;
  String? fullName;
  int? age;
  int? tall;
  int? weight;
  String? category;
  String? note;
  String? dateRecord;
  String? upToRecord;
  int? archive;
  File? image;
  SubscriberModel(
      {this.id,
      this.fullName,
      this.age,
      this.tall,
      this.weight,
      this.category,
      this.note,
      this.dateRecord,
      this.upToRecord,
      this.archive,
      this.image});
  SubscriberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    age = json['age'];
    tall = json['tall'];
    weight = json['weight'];
    category = json['category'];
    note = json['note'];
    dateRecord = json['dateRecord'];
    upToRecord = json['upToRecord'];
    archive = json['archive'];
    if (json['image'] != null) {
      image = File(json['image']);
    }
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    //data['id'] = id;
    data['fullName'] = fullName;
    data['tall'] = tall;
    data['age'] = age;
    data['weight'] = weight;
    data['category'] = category;
    data['note'] = note;
    data['dateRecord'] = dateRecord;
    data['upToRecord'] = upToRecord;
    data['archive'] = archive;
    data['image'] = image?.path;
    debugPrint("tojson...:---${data['image']}");
    return data;
  }
}
