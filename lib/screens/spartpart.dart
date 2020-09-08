import 'package:flutter/material.dart';
import 'package:vehispace/provider/appbartitle.dart';

class SpareParts extends StatefulWidget {
  @override
  _SparePartsState createState() => _SparePartsState();
}

class _SparePartsState extends State<SpareParts> {
  @override

    void initState () {
    super.initState();
      AppBarTitle().appBarTitle = 'Spare Parts';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.4),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Spare Parts Store would be available soon', style: TextStyle(fontFamily: 'Sansation', fontSize: 20,)),
        ),
      ],
    );
  }
}