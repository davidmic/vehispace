import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/screens/offered_services.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:vehispace/utils/notificationpersistence.dart';

class MyNotification extends StatefulWidget {
//  final List message;
//  MyNotification({this.message});
  @override
  _MyNotificationState createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  bool x = false;
 bool  showLeading = false;

 final format = DateFormat('dd/MM/yy');
 List<Message> notification = MyHomePageState.messages;
  Firestore _store = Firestore.instance;
 @override

//  void initState () {
//    super.initState();
//    StoreNotification().writeToStorage(notification);

//    StoreNotification().readFromStorage().then((value){
//      setState(() {
//        notification.addAll(value);
//      });

//    print(value);
//    });
//  }
//  @override

  Widget build(BuildContext context) {
    var userprofile = Provider.of<UserProfile>(context);
    Widget page;
    try {
      page = Scaffold(
        backgroundColor: Color(0xffe5e5e5),
        appBar: AppBar(
          elevation: 0,
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
           showLeading ? IconButton(
              icon: Icon(Icons.check),
              onPressed: (){
                setState(() {
                  showLeading = false;
                });
              },
              iconSize: 30,
              color: Color(0xff003399),
            ): Container(),
          ],
        ),
        body: //notification.length == 0 ? Center(child: Text('No New Notification')) :
        StreamBuilder<QuerySnapshot>(
          stream: _store.collection('usermanagement').document(userprofile.userid).collection('notification').snapshots(),
          builder: (context, snapshot) {
            Widget page;
            if(snapshot.hasData) {
              var data = snapshot.data.documents;
              page = ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return data.length == 0 ? Center(child: Text('No New Notification')) :
                  Card(
                    color: showLeading ? Colors.grey : Colors.white,
                    child: ListTile (
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data[index]['title'].toString(),
                          style: TextStyle(fontFamily: 'Sansation', fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data[index]['body'].toString(),

                          textAlign: TextAlign.justify,
                          softWrap: true,
                          style: TextStyle(fontFamily: 'Sansation', fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),
                        ),
                      ),
                      trailing: Column(
                        children: <Widget>[
                          Text(data[index]['date'] ?? '', style: TextStyle(color: Color(0xffff0000), fontFamily: 'Sansation', fontSize: 12),),
//                          SizedBox(height: 30,),
                        ],
                      ),
                      onTap: (){
                        setState(() {
                          showLeading = true;
                        });
                      },
                      leading: showLeading ? IconButton(
                        icon: Icon(Icons.delete, color: Colors.red, size: 30,),
                        onPressed: () async {
                          await _store.collection('usermanagement').document(userprofile.userid).collection('notification').document(data[index].documentID).delete();
                        },
                      ) : Icon(Icons.notifications, color: Color(0xff003399), size: 30,),
                    ),
                  );
                },
              );
            } else if (!snapshot.hasData) {
              page = Center(child: Text('No Notification'));
            }
            return page;
          }
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
    body: Center(child: Text('No Notification',
      style: TextStyle(fontFamily: 'Sansation', fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
    ),),
      );
    }
    return page;
  }
}
