
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';

class VehispaceSearch extends SearchDelegate {



  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context, null);
        },
        );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('Vehicles').document(query).snapshots(),
      builder: (context, snapshot) {
        Widget page;
        if (!snapshot.hasData) {
          page = Center(child: Text('No Result', style: TextStyle(fontSize: 26, fontFamily: 'Sansation', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),));
        } else if (snapshot.hasData){
          var data = snapshot.data;
          page = ListTile(
              title: Text(data['vehicle'],
              style: TextStyle(
              fontSize: 12,
              fontFamily: 'Sansation',
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
          );
        }
        return page;
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemCount: MyVehicleBloc.vehicle.length,
      itemBuilder: (context, snapshot) {
        return ListTile(
            title: Text(MyVehicleBloc.vehicle[snapshot],
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Sansation',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          onTap: (){
              query = MyVehicleBloc.vehicle[snapshot];
          },
        );
      }
    );
  }
  
}