import 'package:covid19_south_america/src/blocs/all_statistic_bloc.dart';
import 'package:covid19_south_america/src/blocs/statistic_bloc.dart';
import 'package:covid19_south_america/src/models/all_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:url_launcher/url_launcher.dart';

class WorldSummaryScreen extends StatefulWidget {
  WorldSummaryScreenState createState() => new WorldSummaryScreenState();
}

class WorldSummaryScreenState extends State<WorldSummaryScreen> {
  _launchURL(urlParameter) async {
    String url = urlParameter.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo ir a $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    blocAllStatistic.fetchAllStatistic(
        "http://api.coronastatistics.live/", "all");

    Widget buildView(AsyncSnapshot<AllStadisticModel> snapshot) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 18, top: 20),
          child: Text(
            "Resumen",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 0.5),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18, top: 6),
          child: Text(
            "Mundial",
            style: TextStyle(
                color: Colors.white, fontSize: 30, letterSpacing: 0.5),
          ),
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          "assets/home/virus.png",
                        ),
                      ),
                      Text(
                        NumberFormat.compact()
                            .format(int.parse(snapshot.data.cases.toString()))
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child:
                            Text("Casos", style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  elevation: 5.0,
                ),
              ),
              Container(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          "assets/home/death.png",
                        ),
                      ),
                      Text(
                        NumberFormat.compact()
                            .format(int.parse(snapshot.data.deaths.toString()))
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text("Fallecidos",
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  elevation: 5.0,
                ),
              ),
              Container(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          "assets/home/together.png",
                        ),
                      ),
                      Text(
                        NumberFormat.compact()
                            .format(
                                int.parse(snapshot.data.recovered.toString()))
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text("Recuperados",
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  elevation: 5.0,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(
                      "https://www.who.int/gpsc/information_centre/gpsc_lavarse_manos_poster_es.pdf?ua=1");
                },
                child: Container(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            "assets/home/hands.png",
                          ),
                        ),
                        Text(
                          "Cuidados",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text("Diarios",
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    elevation: 5.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]);
    }

    return Container(
      color: Theme.of(context).primaryColor,
      child: StreamBuilder(
        stream: blocAllStatistic.allStatistic,
        builder: (context, AsyncSnapshot<AllStadisticModel> snapshot) {
          if (snapshot.hasData) {
            return buildView(snapshot);
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
  }
}
