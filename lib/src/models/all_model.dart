// To parse this JSON data, do
//
//     final allStadisticModel = allStadisticModelFromJson(jsonString);

import 'dart:convert';

AllStadisticModel allStadisticModelFromJson(String str) => AllStadisticModel.fromJson(json.decode(str));

String allStadisticModelToJson(AllStadisticModel data) => json.encode(data.toJson());

class AllStadisticModel {
  int cases;
  int deaths;
  int recovered;
  int updated;

  AllStadisticModel({
    this.cases,
    this.deaths,
    this.recovered,
    this.updated,
  });

  factory AllStadisticModel.fromJson(Map<String, dynamic> json) => AllStadisticModel(
    cases: json["cases"],
    deaths: json["deaths"],
    recovered: json["recovered"],
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "cases": cases,
    "deaths": deaths,
    "recovered": recovered,
    "updated": updated,
  };
}
