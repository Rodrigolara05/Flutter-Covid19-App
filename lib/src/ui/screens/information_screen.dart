import 'dart:async';

import 'package:covid19_south_america/src/blocs/statistic_bloc.dart';
import 'package:covid19_south_america/src/models/country_model.dart';
import 'package:covid19_south_america/src/models/statistic_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

class InformationScreen extends StatefulWidget {
  CountryModel argsCountryModel;

  InformationScreen(this.argsCountryModel);

  InformationScreenState createState() => new InformationScreenState();
}

class InformationScreenState extends State<InformationScreen> {
  double lat;
  double zoom;
  double _currentOpacity = 1.0;
  bool create = true;

  _chooseZoom() {
    switch (widget.argsCountryModel.cioc) {
      case "ARG":
        {
          lat = 27.0;
          zoom = 3.0;
        }
        break;
      case "BRA":
        {
          lat = 34.0;
          zoom = 3.0;
        }
        break;
      case "CHI":
        {
          lat = 33.0;
          zoom = 2.8;
        }
        break;
      case "ECU":
        {
          lat = 4.9;
          zoom = 5.5;
        }
        break;
      case "GUY":
        {
          lat = 9.0;
          zoom = 5.0;
        }
        break;
      case "PAR":
        {
          lat = 8.0;
          zoom = 5.0;
        }
        break;
      case "SUR":
        {
          lat = 9.0;
          zoom = 5.0;
        }
        break;
      case "URU":
        {
          lat = 7.0;
          zoom = 5.0;
        }
        break;
      default:
        {
          lat = 16.0;
          zoom = 4.0;
        }
    }
  }

  _selectedPais(CountryModel argsCountryModel) {
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

  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => setState(() {
              _currentOpacity = 0.0;
            }));
    // () => Navigator.pushReplacementNamed(context, "/home"));
  }

  @override
  Widget build(BuildContext context) {
    blocStatistic.fetchStatisticByCountry(
        "http://api.coronastatistics.live/countries/",
        widget.argsCountryModel.cioc != "" &&
                widget.argsCountryModel.nativeName != "Uruguay" &&
                widget.argsCountryModel.nativeName != "Venezuela"
            ? widget.argsCountryModel.cioc.toString()
            : widget.argsCountryModel.name.toString() == "French Guiana"
                ? widget.argsCountryModel.name.toString()
                : widget.argsCountryModel.nativeName.toString());

    String tittle = "#QuedateEnCasa";

    _chooseZoom();

    Widget buildMap() {
      return new FlutterMap(
        options: new MapOptions(
            center: LatLng(widget.argsCountryModel.latlng[0] - lat,
                widget.argsCountryModel.latlng[1]),
            zoom: zoom,
            interactive: false),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 50.0,
                height: 50.0,
                point: LatLng(widget.argsCountryModel.latlng[0],
                    widget.argsCountryModel.latlng[1]),
                builder: (ctx) => new Container(
                  child: new Image.asset(
                    "assets/information/buscando_virus.gif",
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    CircleAvatar circleAvatar_Asset = new CircleAvatar(
      backgroundImage: AssetImage(
        "assets/southAmerica/flag" +
            widget.argsCountryModel.nativeName.replaceAll(" ", "") +
            ".png",
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
    CircleAvatar circleAvatar_Network = new CircleAvatar(
      child: ClipOval(
        child: SvgPicture.network(
          widget.argsCountryModel.flag,
          fit: BoxFit.fill,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    Widget buildContainer(AsyncSnapshot<StatisticModel> snapshot) {
      return Container(
        child: Stack(
          children: <Widget>[
            buildMap(),
            Positioned(
              bottom: 15,
              left: 5,
              right: 5,
              child: Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: _selectedPais(widget.argsCountryModel) == false
                          ? circleAvatar_Network
                          : circleAvatar_Asset,
                      title: Text(widget.argsCountryModel.nativeName),
                      subtitle:
                          Text("Capital: " + widget.argsCountryModel.capital),
                      trailing: Tooltip(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Casos/Población"),
                            Text((
                                ((snapshot.data.cases /
                                    widget.argsCountryModel
                                        .population) *
                                    100)
                                    .toStringAsFixed(2)
                                    .toString() +
                                    "%"
                            )),
                          ],
                        ),
                        message: "Porcentaje: " + (
                            ((snapshot.data.cases /
                                widget.argsCountryModel
                                    .population) *
                                100)
                                .toStringAsFixed(2)
                                .toString() +
                                "%"
                        ),
                      ),
                    ),
                    Container(
                      height: 300.0,
                      child: Stack(
                        children: <Widget>[
                          NotificationListener<ScrollNotification>(
                            child: ListView(
                              children: <Widget>[
                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("Población total"),
                                      Text(
                                        NumberFormat.compact().format(int.parse(
                                            widget.argsCountryModel.population
                                                .toString())),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("Casos totales"),
                                      Text(
                                        snapshot.data.cases.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("Casos nuevos (Hoy)"),
                                      Text(
                                        snapshot.data.todayCases.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("Fallecidos"),
                                      Text(
                                        snapshot.data.deaths.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("Fallecidos (Hoy)"),
                                      Text(
                                        snapshot.data.todayDeaths.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("Recuperados"),
                                      Text(
                                        snapshot.data.recovered.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("Sin Recuperar"),
                                      Text(
                                        snapshot.data.active.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("En estado critico"),
                                      Text(
                                        snapshot.data.critical.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),


                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("Casos por millon"),
                                      Text(
                                        snapshot.data.casesPerOneMillion.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Divider(
                                  height: 0.3,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text("Fallecidos por millon"),
                                      Text(
                                        snapshot.data.deathsPerOneMillion.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                  ),
                                ),


                              ],
                            ),
                          ),
                          Positioned(
                            left: (MediaQuery.of(context).size.width / 2 - 20),
                            bottom: 8,
                            child: AnimatedOpacity(
                              duration: const Duration(seconds: 1),
                              opacity: _currentOpacity,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Theme.of(context).accentColor,
                                foregroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_downward,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ],
        ),
      );
    }

    Scaffold scaffold = new Scaffold(
      appBar: AppBar(
        title: Text(tittle + widget.argsCountryModel.nativeName),
      ),
      body: StreamBuilder(
        stream: blocStatistic.statisticByCountry,
        builder: (context, AsyncSnapshot<StatisticModel> snapshot) {
          if (snapshot.hasData) {
            return buildContainer(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ));
        },
      ),
    );
    return scaffold;
  }
}
