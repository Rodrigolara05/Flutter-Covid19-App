import 'package:covid19_south_america/src/models/statistic_model.dart';
import 'package:covid19_south_america/src/models/country_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StatisticBloc {
  final _repository = RepositoryStatistic();
  final _statisticFetcher = PublishSubject<StatisticModel>();

  Observable<StatisticModel> get statisticByCountry => _statisticFetcher.stream;

  fetchStatisticByCountry(String url,String country) async {
    StatisticModel itemModel = await _repository.fetchStatisticByCountry(url,country);
    _statisticFetcher.sink.add(itemModel);
  }

  dispose() {
    _statisticFetcher.close();
  }
}

final blocStatistic = StatisticBloc();

