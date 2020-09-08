import 'package:flutter/material.dart';

class AppBarTitle extends ChangeNotifier{
  static String appBartilte;

  get appBarTitle => appBartilte;

  set appBarTitle (String value) => appBartilte = value;

  changeTitle ({String pageTitle}) {
    appBarTitle = pageTitle;
    notifyListeners();
  }
}