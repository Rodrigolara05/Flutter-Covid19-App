import 'package:covid19_south_america/src/models/country_model.dart';
import 'package:covid19_south_america/src/ui/screens/information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GridBuilderWidget extends StatefulWidget {
  AsyncSnapshot<ListCountryModel> snapshot;

  GridBuilderWidget(this.snapshot);

  GridBuilderWidgetState createState() => new GridBuilderWidgetState();
}

class GridBuilderWidgetState extends State<GridBuilderWidget> {
  _selectedPais(CountryModel argsCountryModel) {
    if (argsCountryModel.nativeName == "Argentina" ||
        argsCountryModel.nativeName == "Brasil" ||
        argsCountryModel.nativeName == "Falkland Islands" ||
        argsCountryModel.nativeName == "South Georgia") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Widget buildGrid(AsyncSnapshot<ListCountryModel> snapshot) {
      return GridView.builder(
          primary: false,
          padding: const EdgeInsets.all(20),
          itemCount: snapshot.data.results.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Card(
                elevation: 5.0,
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          //color: Colors.grey,
                          child: _selectedPais(snapshot.data.results[index]) ==
                                  false
                              ? SvgPicture.network(
                                  snapshot.data.results[index].flag.toString(),
                                  width: 80,
                                  semanticsLabel:
                                      snapshot.data.results[index].nativeName,
                                  placeholderBuilder: (BuildContext context) =>
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 40.0),
                                          child:
                                              const CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          )),
                                )
                              : Image.asset(
                                  "assets/southAmerica/flag" +
                                      snapshot.data.results[index].nativeName
                                          .replaceAll(" ", "") +
                                      ".png",
                                  width: 85,
                                  semanticLabel:
                                      snapshot.data.results[index].nativeName,
                                ),
                        ),
                      ),
                      Text(
                        snapshot.data.results[index].nativeName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        InformationScreen(snapshot.data.results[index])));
              },
            );
          });
    }

    return buildGrid(widget.snapshot);
  }
}
