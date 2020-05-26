import 'package:covid19_south_america/src/blocs/countries_bloc.dart';
import 'package:covid19_south_america/src/models/country_model.dart';
import 'package:covid19_south_america/src/states/type_view_state.dart';
import 'package:covid19_south_america/src/ui/pages/widgets/gridBuilder.dart';
import 'package:covid19_south_america/src/ui/pages/widgets/listBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SouthAmericaScreen extends StatefulWidget {
  SouthAmericaScreenState createState() => new SouthAmericaScreenState();
}

class SouthAmericaScreenState extends State<SouthAmericaScreen> {
  @override
  Widget build(BuildContext context) {
    blocCountries.fetchAllCountries();

    return Container(
      color: Theme.of(context).primaryColor,
      child: new StreamBuilder(
        stream: blocCountries.allCountries,
        builder: (context, AsyncSnapshot<ListCountryModel> snapshot) {
          if (snapshot.hasData) {
            var stateTypeView = Provider.of<TypeViewState>(context);
            return stateTypeView.isListViewOn() == true
                ? ListBuilderWidget(snapshot)
                : GridBuilderWidget(snapshot);



          } else if (snapshot.hasError) {
            return new Text(snapshot.error.toString());
          }
          return new Center(
              child: new CircularProgressIndicator(
            backgroundColor: Colors.white,
          ));
        },
      ),
    );
  }
}
