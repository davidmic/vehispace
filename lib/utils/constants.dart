import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class Constants {

  static var redText =
    TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.red,
        fontFamily: 'Sansation'
     );

  static var titleText = TextStyle(
    color: Color(0xff003399),
    fontWeight: FontWeight.bold,
    fontSize: 34,
    fontFamily: 'Sansation'
  );

  static var subtitleText = TextStyle(
    color: Colors.black54,
    fontSize: 16,
      fontFamily: 'Sansation'
  );

  static var drawerliststyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Sansation', fontStyle: FontStyle.normal);

  static var appBarTitleColor = TextStyle(color: Color(0xff003399), fontFamily: 'Sansation', fontWeight: FontWeight.bold, fontSize: 16);

  static TextStyle navBarStyle = TextStyle(fontFamily: 'Sensation', fontWeight: FontWeight.bold, fontSize: 12,);
}