// To parse this JSON data, do
//
//     final historyPageModel = historyPageModelFromJson(jsonString);

import 'dart:convert';

List<HistoryPageModel> historyPageModelFromJson(String str) => List<HistoryPageModel>.from(json.decode(str).map((x) => HistoryPageModel.fromJson(x)));

String historyPageModelToJson(List<HistoryPageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryPageModel {
  int id;
  String imagePath;
  String imagePathSvg;
  String title;
  String category;
  String date;
  DateTime createdAt;

  HistoryPageModel({
    required this.id,
    required this.imagePath,
    required this.imagePathSvg,
    required this.title,
    required this.category,
    required this.date,
    required this.createdAt,
  });

  factory HistoryPageModel.fromJson(Map<String, dynamic> json) => HistoryPageModel(
    id: json["id"],
    imagePath: json["image_path"],
    imagePathSvg: json["image_path_svg"],
    title: json["title"],
    category: json["category"],
    date: json["date"].toString(),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_path": imagePath,
    "image_path_svg": imagePathSvg,
    "title": title,
    "category": category,
    "date": date,
    "createdAt": createdAt.toIso8601String(),
  };
}

// enum Date { THE_2942023, THE_3042023 }
//
// final dateValues = EnumValues({
//   "29-4-2023": Date.THE_2942023,
//   "30-4-2023": Date.THE_3042023
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
