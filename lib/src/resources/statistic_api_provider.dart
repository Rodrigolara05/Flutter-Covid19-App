import 'dart:async';
import 'package:covid19_south_america/src/models/all_model.dart';
import 'package:covid19_south_america/src/models/statistic_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class CoronaStatisticApiProvider {
  Client client = Client();
  //String url="http://api.coronastatistics.live/countries/";
  //final _apiKey = 'your_api_key';

  Future<ListStatisticModel> fetchStatisticCountries() async {
    final response = await client
        .get("http://api.coronastatistics.live/countries");
    if (response.statusCode == 200) {
      return ListStatisticModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<StatisticModel> fetchStatisticByCountry(String url,String country) async {
    final response = await client
        .get(url+country);

    if (response.statusCode == 200) {
      return StatisticModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<AllStadisticModel> fetchAllStatistic(String url,String country) async {
    final response = await client
        .get(url+country);

    if (response.statusCode == 200) {
      return AllStadisticModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
