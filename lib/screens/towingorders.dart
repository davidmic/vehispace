import 'package:flutter/material.dart';
import 'package:vehispace/utils/constants.dart';

class TowingOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff003399),
        ),
        backgroundColor: Color(0xfff4f4f4),
        centerTitle: true,
        title: Text('Towing Orders', style: Constants.appBarTitleColor,),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
