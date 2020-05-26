import 'dart:async';
import 'package:covid19_south_america/src/models/country_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class CountryApiProvider {
  Client client = Client();
  String url="https://restcountries.eu/rest/v2/regionalbloc/";
  String region="USAN";
  //final _apiKey = 'your_api_key';

  Future<ListCountryModel> fetchCountryList() async {
    final response = await client
        .get(url+region);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ListCountryModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


}
