import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/utils/constants.dart';

class MyVehiclePaperOrders extends StatefulWidget {
  @override
  _MyVehiclePaperOrdersState createState() => _MyVehiclePaperOrdersState();
}

class _MyVehiclePaperOrdersState extends State<MyVehiclePaperOrders> {
  bool x = false;
  List<Map<String, dynamic>> not = [
    {
      'title' : 'Order 1',
      'message' : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
          'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      'date' : '02-02-19'
    },
    {
      'title' : 'Order 2',
      'message' : 'Morem ipsum dolor sit amet, consectetur adipiscing elit, '
          'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      'date' : '02-02-30'
    },
  ];
  Firestore _store = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    var userProfile = Provider.of<UserProfile>(context);
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff003399),
        ),
        backgroundColor: Color(0xfff4f4f4),
        centerTitle: true,
        title: Text(
          'Vehicle Paper Orders',
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.collection('vehiclerenewalrequest').document(userProfile.userid).collection('request').snapshots(),
          builder: (context, snapshot) {
            Widget page;
            if (!snapshot.hasData) {
              page = Center(child: Text('No Vehicle Paper Requests'),);
            }
            else if (snapshot.hasData) {
              var request = snapshot.data.documents;
              print (request);
              page =ListView.builder(
                itemCount: request.length,
                itemBuilder: (context, snapshot) {
                  final mapContains = request;
                  return Card(
                    child: ExpansionTile (
                      leading: Column(
                        children: <Widget>[
                          Text(''),
                          Text(mapContains[snapshot]['requestDate']?? '', style: TextStyle(color: Color(0xffff0000), fontFamily: 'Sansation', fontSize: 12),),
                        ],
                      ),
                      title: Text(mapContains[snapshot]['registrationNumber'] ?? '',
//                    textAlign: TextAlign.justify,
//                    softWrap: true,
                        style: TextStyle(fontFamily: 'Sansation', fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),
                      ),
                      subtitle: Text(mapContains[snapshot]['vehicleMake'] ?? ''),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:30.0, bottom: 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('Road Worthiness Renewal : '),
                                  Text(mapContains[snapshot]['roadWorthiness'] ?? ''),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  Text('Insurance Renewal : '),
                                  Text(mapContains[snapshot]['insuranceRenewal'] ?? ''),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],

                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
//                      request[snapshot].de;
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return page;
          }
      ),

    );
  }
}
