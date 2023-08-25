class SubscriberModel {
  int? id;
  String? fullName;
  int? tall;
  int? weight;
  String? category;
  String? note;
  DateTime? dateRecord;
  DateTime? upToRecord;
  SubscriberModel(
      {this.id,
      this.fullName,
      this.tall,
      this.weight,
      this.category,
      this.note,
      this.dateRecord,
      this.upToRecord});
  SubscriberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tall = json['tall'];
    weight = json['weight'];
    category = json['category'];
    note = json['note'];
    dateRecord = json['dateRecord'];
    upToRecord = json['upToRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['tall'] = tall;
    data['weight'] = weight;
    data['category'] = category;
    data['note'] = note;
    data['dateRecord'] = dateRecord;
    data['upToRecord'] = upToRecord;
    return data;
  }
}
