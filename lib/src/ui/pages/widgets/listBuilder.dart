import 'package:animate_do/animate_do.dart';
import 'package:covid19_south_america/src/blocs/countries_statistic_bloc.dart';
import 'package:covid19_south_america/src/models/country_model.dart';
import 'package:covid19_south_america/src/models/statistic_model.dart';
import 'package:covid19_south_america/src/ui/screens/information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ListBuilderWidget extends StatefulWidget {
  AsyncSnapshot<ListCountryModel> snapshot;

  ListBuilderWidget(this.snapshot);

  ListBuilderWidgetState createState() => new ListBuilderWidgetState();
}

class ListBuilderWidgetState extends State<ListBuilderWidget> {
  _selectedPaisPhoto(CountryModel argsCountryModel) {
    if (argsCountryModel.nativeName == "Argentina" ||
        argsCountryModel.nativeName == "Brasil" ||
        argsCountryModel.nativeName == "Chile" ||
        argsCountryModel.nativeName == "Falkland Islands" ||
        argsCountryModel.nativeName == "South Georgia" ||
        argsCountryModel.nativeName == "Uruguay") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _circleAvatarAsset(CountryModel argsCountry) {
      CircleAvatar circleAvatar_Asset = new CircleAvatar(
        backgroundImage: AssetImage(
          "assets/southAmerica/flag" +
              argsCountry.nativeName.replaceAll(" ", "") +
              ".png",
        ),
        backgroundColor: Theme.of(context).primaryColor,
      );
      return circleAvatar_Asset;
    }

    _circleAvatarNetwork(CountryModel argsCountry) {
      CircleAvatar circleAvatar_Network = new CircleAvatar(
        child: ClipOval(
          child: SvgPicture.network(
            argsCountry.flag,
            fit: BoxFit.fill,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      );
      return circleAvatar_Network;
    }

    buildListTitle(StatisticModel snapshot, CountryModel argsCountryModel) {
      return Container(
        child: Column(
          children: <Widget>[
            Divider(
              height: 0.3,indent: 15,endIndent: 15,
            ),
            ListTile(
              leading: _selectedPaisPhoto(argsCountryModel) == false
                  ? _circleAvatarNetwork(argsCountryModel)
                  : _circleAvatarAsset(argsCountryModel),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(snapshot.country),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red[500],
                        ),
                        color: Colors.red[700],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Text(
                        NumberFormat.compact()
                            .format(int.parse(snapshot.cases.toString())),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Text(
                        NumberFormat.compact()
                            .format(int.parse(snapshot.deaths.toString())),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green[500],
                        ),
                        color: Colors.green[700],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Text(
                        NumberFormat.compact()
                            .format(int.parse(snapshot.recovered.toString())),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InformationScreen(argsCountryModel)));
              },
            ),
          ],
        ),
        color: Colors.white,
      );
    }

    Widget buildList(snapshot) {
      blocCountriesStatistic.fetchStatisticCountries();

      _informationItem(String text, Color color) {
        Widget notificationCircle(Color color) {
          return new Container(
            width: 10.0,
            height: 10.0,
            decoration: new BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          );
        }

        return new Column(
          children: <Widget>[
            Expanded(
              child: notificationCircle(color),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 13.2),
              ),
            ),
          ],
        );
      }

      Container containerLeyend = new Container(
        height: 40,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: _informationItem("Casos", Colors.red[700]),
            ),
            Expanded(
              child: _informationItem("Fallecidos", Colors.black),
            ),
            Expanded(
              child: _informationItem("Recuperados", Colors.green[700]),
            ),
          ],
        ),
      );

      return Container(
        child: Column(
          children: <Widget>[
            FadeIn(
              delay: Duration(milliseconds: 0),
              child: containerLeyend,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.results.length,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    CountryModel countryModel = snapshot.data.results[index];
                    return FadeIn(
                      delay: Duration(milliseconds: 180 * (index + 1)),
                      child: new StreamBuilder(
                        stream: blocCountriesStatistic.statisticCountries,
                        builder: (context,
                            AsyncSnapshot<ListStatisticModel> snapshot) {
                          if (snapshot.hasData) {
                            return buildListTitle(
                                snapshot.data.results[index], countryModel);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return Container();
                        },
                      ),
                    );
                  }),
            )
          ],
        ),
      );
    }

    // TODO: implement build
    return buildList(widget.snapshot);
  }
}
