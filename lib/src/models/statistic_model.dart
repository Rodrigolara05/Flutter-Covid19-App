// To parse this JSON data, do
//
//     final StatisticModel = StatisticModelFromJson(jsonString);

import 'dart:convert';

StatisticModel StatisticModelFromJson(String str) => StatisticModel.fromJson(json.decode(str));

String StatisticModelToJson(StatisticModel data) => json.encode(data.toJson());

class ListStatisticModel {
  List<StatisticModel> _results = [];

  ListStatisticModel.fromJson(List<dynamic> parsedJson) {
    List<StatisticModel> temp = [];
    for (int i = 0; i < parsedJson.length; i++) {
      StatisticModel result = StatisticModel.example(parsedJson[i]);
      temp.add(result);
    }
    _results = temp;
  }
  List<StatisticModel> get results => _results;

}

class StatisticModel {
  String country;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  int casesPerOneMillion;
  int deathsPerOneMillion;

  StatisticModel({
    this.country,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
  });

  StatisticModel.example(json){
    country= json["country"];
    cases= json["cases"];
    todayCases= json["todayCases"];
    deaths= json["deaths"];
    todayDeaths= json["todayDeaths"];
    recovered= json["recovered"];
    active= json["active"];
    critical= json["critical"];
    casesPerOneMillion= json["casesPerOneMillion"].round();
    deathsPerOneMillion= json["deathsPerOneMillion"].round();
  }
  
  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
    country: json["country"],
    cases: json["cases"],
    todayCases: json["todayCases"],
    deaths: json["deaths"],
    todayDeaths: json["todayDeaths"],
    recovered: json["recovered"],
    active: json["active"],
    critical: json["critical"],
    casesPerOneMillion: json["casesPerOneMillion"].round(),
    deathsPerOneMillion: json["deathsPerOneMillion"].round(),
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "cases": cases,
    "todayCases": todayCases,
    "deaths": deaths,
    "todayDeaths": todayDeaths,
    "recovered": recovered,
    "active": active,
    "critical": critical,
    "casesPerOneMillion": casesPerOneMillion,
    "deathsPerOneMillion": deathsPerOneMillion,
  };
}
