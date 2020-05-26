import 'package:covid19_south_america/src/models/country_model.dart';
import 'package:covid19_south_america/src/ui/screens/home_screen.dart';
import 'package:covid19_south_america/src/ui/screens/information_screen.dart';
import 'package:covid19_south_america/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: new Color.fromRGBO(16, 52, 100, 1),
        accentColor: new Color.fromRGBO(40, 68, 116, 1),
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomeScreen(),
        '/information': (BuildContext context) => new InformationScreen(new CountryModel()),
      },
    );
  }
}
