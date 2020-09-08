import 'package:flutter/material.dart';
import 'package:vehispace/utils/constants.dart';

class MyNotification extends StatefulWidget {
  final List message;
  MyNotification({this.message});
  @override
  _MyNotificationState createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  bool x = false;
  List<Map<String, dynamic>> not = [
    {
      'message' : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                  'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      'date' : '02-02-19'
    },
    {
      'message' : 'Morem ipsum dolor sit amet, consectetur adipiscing elit, '
                  'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      'date' : '02-02-30'
    },
  ];


  @override
  Widget build(BuildContext context) {
    Widget page;
    try {
      page = Scaffold(
        backgroundColor: Color(0xffe5e5e5),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff003399),
          ),
          backgroundColor: Color(0xfff4f4f4),
          centerTitle: true,
          title: Text(
            'Notification',
            style: Constants.appBarTitleColor,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: x == true ? (){} : null,
//            iconSize: 30,
              color: Color(0xff003399),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: widget.message.length,
          itemBuilder: (context, index) {
//          final mapContains = not[index];
            return Card(
//              padding: EdgeInsets.only(bottom: 30),
              color: x == true ? Colors.grey : Colors.white,
              child: ListTile (
                onLongPress: (){
                  setState(() {
                    x = true;
                  });
                },
                onTap: (){
                  setState(() {
                    x = false;
                  });
                },
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.message[index].body.toString(),

                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Sansation', fontSize: 12, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),
                  ),
                ),
                trailing: Text('00/00/00', style: TextStyle(color: Color(0xffff0000), fontFamily: 'Sansation', fontSize: 8),),
              ),
            );
          },
        ),

      );
    } catch (e) {
      page = Scaffold(
          backgroundColor: Color(0xffe5e5e5),
          appBar: AppBar(
          iconTheme: IconThemeData(
          color: Color(0xff003399),
    ),
    backgroundColor: Color(0xfff4f4f4),
    centerTitle: true,
    title: Text(
    'Notification',
    style: Constants.appBarTitleColor,
    ),
          ),
    body: Center(child: Text('No Notification'),
      ),
      );
    }
    return page;
  }
}
