import 'package:covid19_south_america/src/states/type_view_state.dart';
import 'package:covid19_south_america/src/ui/pages/south_america_page.dart';
import 'package:covid19_south_america/src/ui/pages/world_summary_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

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
    List<Widget> listPages = [
      WorldSummaryScreen(),
      SouthAmericaScreen(),
    ];

    BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 10.0,
      items: [
        BottomNavigationBarItem(
            title: Text("En el mundo"),
            icon: Icon(
              FontAwesomeIcons.globeAmericas,
            )),
        BottomNavigationBarItem(
            title: Text("Sudamérica"),
            icon: Icon(
              FontAwesomeIcons.home,
            )),
      ],
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );

    IconButton _informationButton = new IconButton(
      icon: Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      onPressed: () {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Información"),
                content: Container(
                  height: 145,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/splashScreen/profile.jpg"),
                          ),
                          title: Text("Rodrigo Lara"),
                          subtitle: Text("Software Engineer"),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.image),
                          ),
                          title: Text("Imagenes de"),
                          subtitle: Text("Freepick"),
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 24.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "Contactame",
                    ),
                    onPressed: () {
                      _launchURL("https://www.linkedin.com/in/RodrigoLara05/");
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Donación",
                    ),
                    onPressed: () {
                      _launchURL("https://www.paypal.me/RodrigoMax");
                    },
                  ),
                ],
              );
            });
      },
    );

    List<Widget> actionHome = <Widget>[
      _informationButton,
    ];
    _actionSouth(BuildContext context) {
      var stateTypeView = Provider.of<TypeViewState>(context);
      List<Widget> actionSouth = <Widget>[
        //_informationButton,
        IconButton(
          icon: Icon(
            stateTypeView.isListViewOn() == true ? Icons.grid_on : Icons.list,
            color: Colors.white,
          ),
          onPressed: () {
            stateTypeView.isListViewOn() == true
                ? stateTypeView.disableModeListView()
                : stateTypeView.enableModeListView();
          },tooltip: "Cambiar vista",
        ),
      ];
      return actionSouth;
    }
    _appBar(BuildContext context) {
      AppBar appBar = new AppBar(
        title: Text("#QuedateEnCasa"),
        actions: selectedIndex == 0 ? actionHome : _actionSouth(context),
      );
      return appBar;
    }
    return ChangeNotifierProvider<TypeViewState>(
        builder: (BuildContext context) => TypeViewState(),
        child: Consumer<TypeViewState>(
          builder: (context, provider, child) =>  Scaffold(
            appBar: _appBar(context),
            body: listPages.elementAt(selectedIndex),
            bottomNavigationBar: bottomNavigationBar,
          ),
    )

    );
  }
}
