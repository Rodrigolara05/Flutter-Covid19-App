import 'package:covid19_south_america/src/models/statistic_model.dart';
import 'package:covid19_south_america/src/models/country_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CountriesStatisticBloc {
  final _repository = RepositoryStatistic();
  final _statisticFetcher = PublishSubject<ListStatisticModel>();

  Observable<ListStatisticModel> get statisticCountries =>
      _statisticFetcher.stream;

  fetchStatisticCountries() async {
    ListStatisticModel itemModel = await _repository.fetchStatisticCountries();
    itemModel.results.removeWhere((item) =>
    item.country != "Peru" &&
        item.country != "Argentina" &&
        item.country != "Bolivia" &&
        item.country != "Brazil" &&
        item.country != "Chile" &&
        item.country != "Colombia" &&
        item.country != "Ecuador" &&
        item.country != "Falkland Islands" &&
        item.country != "Guyana" &&
        item.country != "French Guiana" &&
        item.country != "Paraguay" &&
        item.country != "Suriname" &&
        item.country != "Uruguay" &&
        item.country != "Venezuela");
    itemModel.results.sort((a,b)=>a.country.compareTo(b.country));
    //itemModel.results.sort((a,b)=>a.cases.compareTo(b.cases));
    _statisticFetcher.sink.add(itemModel);
  }

  dispose() {
    _statisticFetcher.close();
  }
}

final blocCountriesStatistic = CountriesStatisticBloc();
