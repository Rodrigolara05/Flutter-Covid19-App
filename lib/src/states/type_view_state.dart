import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypeViewState with ChangeNotifier{
  bool _listViewOn=false;
  bool isListViewOn()=>_listViewOn;


  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('boolValue');
    return boolValue;
  }

  addBoolToSF(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', value);
  }

  void enableModeListView(){
    _listViewOn = true;
    addBoolToSF(_listViewOn);
    notifyListeners();
  }

  void disableModeListView(){
    _listViewOn = false;
    addBoolToSF(_listViewOn);
    notifyListeners();
  }

}