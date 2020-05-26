import 'package:covid19_south_america/src/models/all_model.dart';
import 'package:covid19_south_america/src/models/statistic_model.dart';
import 'package:covid19_south_america/src/models/country_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AllStatisticBloc {
  final _repository = RepositoryStatistic();
  final _statisticFetcher = PublishSubject<AllStadisticModel>();

  Observable<AllStadisticModel> get allStatistic => _statisticFetcher.stream;

  fetchAllStatistic(String url,String country) async {
    AllStadisticModel itemModel = await _repository.fetchAllStatistic(url,country);
    _statisticFetcher.sink.add(itemModel);
  }

  dispose() {
    _statisticFetcher.close();
  }
}

final blocAllStatistic = AllStatisticBloc();