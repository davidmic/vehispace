import 'package:flutter/material.dart';

class GestureCloseButton extends StatelessWidget {

  final String title;
  final String subtitle;

  GestureCloseButton({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.close,
              size: 40,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  color: Color(0xff003399),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                'Securely login to your vehispace',
                style: TextStyle(
                  color: Colors.black54,
//                              fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ]);
  }
}
