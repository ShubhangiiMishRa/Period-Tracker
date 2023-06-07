// To parse this JSON data, do
//
//     final signupPageModel = signupPageModelFromJson(jsonString);

import 'dart:convert';

List<SignupPageModel> signupPageModelFromJson(String str) => List<SignupPageModel>.from(json.decode(str).map((x) => SignupPageModel.fromJson(x)));

String signupPageModelToJson(List<SignupPageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SignupPageModel {
  String name;
  String email;
  String phonenumber;
  String age;
  String sexualActivity;
  String firstdate;
  String daysInCycle;
  String periodFlowDay;

  SignupPageModel({
    required this.name,
    required this.email,
    required this.phonenumber,
    required this.age,
    required this.sexualActivity,
    required this.firstdate,
    required this.daysInCycle,
    required this.periodFlowDay,
  });

  factory SignupPageModel.fromJson(Map<String, dynamic> json) => SignupPageModel(
    name: json["name"],
    email: json["email"],
    phonenumber: json["phonenumber"],
    age: json["age"],
    sexualActivity: json["sexualActivity"],
    firstdate: json["firstdate"],
    daysInCycle: json["daysInCycle"],
    periodFlowDay: json["periodFlowDay"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phonenumber": phonenumber,
    "age": age,
    "sexualActivity": sexualActivity,
    "firstdate": firstdate,
    "daysInCycle": daysInCycle,
    "periodFlowDay": periodFlowDay,
  };
}
