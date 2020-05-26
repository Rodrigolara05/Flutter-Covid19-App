import 'package:covid19_south_america/src/models/country_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CountriesBloc {
  final _repository = RepositoryCountry();
  final _countriesFetcher = PublishSubject<ListCountryModel>();

  Observable<ListCountryModel> get allCountries => _countriesFetcher.stream;

  fetchAllCountries() async {
    ListCountryModel itemModel = await _repository.fetchAllCountries();
    itemModel.results.removeWhere((item) => item.nativeName == "South Georgia");
    _countriesFetcher.sink.add(itemModel);
  }

  dispose() {
    _countriesFetcher.close();
  }
}

final blocCountries = CountriesBloc();
