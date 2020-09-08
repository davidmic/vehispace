import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/screens/vehicledetails.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/myvehiclelist.dart';
import 'package:vehispace/provider/userprofilebloc.dart';

class MyVehicle extends StatefulWidget {
  @override
  _MyVehicleState createState() => _MyVehicleState();
}

class _MyVehicleState extends State<MyVehicle> {

  List listOfCars = [];
  Firestore _store = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    var _userProfile = Provider.of<UserProfile>(context);
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff003399),
        ),
        backgroundColor: Color(0xfff4f4f4),
        centerTitle: true,
        title: Text('Vehicles',
          style: Constants.appBarTitleColor,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
         stream: _store.collection('vehiclemanagement').document(_userProfile.userid).collection('myvehicles').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasData){
            final vehiceData = snapshot.data.documents;
            return vehiceData.length == 0 ? 
            Center(child: Text('You have no Vehicle Registered Yet'),) :
            ListView.builder(
              itemCount: vehiceData.length, //listOfCars.length,
              itemBuilder: (context, index){
            return MyVehicleList(
              imageUrl: CachedNetworkImage(
                imageUrl: vehiceData[index]['imageURL'],
                placeholder: (context, url) => CircularProgressIndicator(),
                fit: BoxFit.fill,
                ),
              vehicle: vehiceData[index]['manufacturer'],
              model: vehiceData[index]['model'],
              callBack: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyVehicleDetail(
                  vehicle: vehiceData[index]['vehicle'],
                  vehicleRegNo: vehiceData[index]['registrationNumber'],
                  manufacturer: vehiceData[index]['manufacturer'],
                  model: vehiceData[index]['model'],
                  engineCapacity: vehiceData[index]['engineCapacity'],
                  engineNumber: vehiceData[index]['engineNumber'],
                  vehicleId: vehiceData[index]['vehicleId'],
                  userId: _userProfile.userid,
                  docId: vehiceData[index].documentID,
                )));
              },
            );
          });
          }
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xff003399),
          child: Icon(Icons.add, color: Colors.white,),
          onPressed: (){
            Navigator.pushNamed(context, '/vehiclereginapp');
          }
          ),
      ),
    );
  }
}
