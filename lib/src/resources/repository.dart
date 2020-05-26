import 'dart:async';
import 'package:covid19_south_america/src/models/all_model.dart';
import 'package:covid19_south_america/src/models/statistic_model.dart';
import 'package:covid19_south_america/src/models/country_model.dart';
import 'package:covid19_south_america/src/resources/statistic_api_provider.dart';

import 'country_api_provider.dart';

class RepositoryCountry {
  final countriesApiProvider = CountryApiProvider();

  Future<ListCountryModel> fetchAllCountries() => countriesApiProvider.fetchCountryList();
}

class RepositoryStatistic {
  final statisticApiProvider = CoronaStatisticApiProvider();

  Future<StatisticModel> fetchStatisticByCountry(String url,String country) => statisticApiProvider.fetchStatisticByCountry(url,country);
  Future<AllStadisticModel> fetchAllStatistic(String url,String country) => statisticApiProvider.fetchAllStatistic(url,country);
  Future<ListStatisticModel> fetchStatisticCountries() => statisticApiProvider.fetchStatisticCountries();

}


