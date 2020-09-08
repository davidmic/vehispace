import 'package:flutter/material.dart';
import 'package:vehispace/models/towingmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Request {sent, notSent}

class TowingBloc extends ChangeNotifier {

  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _store = Firestore.instance;

  TowingModel _towingDetails = TowingModel(
    country: '',
    state: '',
    lga: '',
    vehicle: '',
    brand: '',
    model: '',
    destination: '',
    conditionOfVehicle: '',
    casualty: '',
    additionalInfo: '',
    requestTime: '',
    requestDate: '',
  );
  static double scrLat;
  static double scrLong;

  static double destLat;
  static double destLong;

  Request _request = Request.notSent;

  //request
  get request => _request;
  set request (val) => _request = val;

  //towingdetails
  get towingDetails => _towingDetails;
  set towingDetails (TowingModel val) => _towingDetails = val;

  //scrlocatiionlattitude
  get scrlong => scrLong;
  set scrlong (double val) => scrLong = val;

  //scrlocation longitude
  get scrlat => scrLat;
  set scrlat (double val) => scrLat = val;

  //destlocatiionlattitude
  get destlong => destLong;
  set destlong (double val) => destLong = val;

  //destlocation longitude
  get destlat => destLat;
  set destlat (double val) => destLat = val;

  setTowingDetails ({TowingModel myTowDetails}) {
    towingDetails = TowingModel(
      country: myTowDetails.country,
      state: myTowDetails.state,
      lga: myTowDetails.lga,
      vehicle: myTowDetails.vehicle,
      brand: myTowDetails.brand,
      model: myTowDetails.model,
      location: myTowDetails.location,
      destination: myTowDetails.destination,
      conditionOfVehicle: myTowDetails.conditionOfVehicle,
      casualty: myTowDetails.casualty,
      additionalInfo: myTowDetails.additionalInfo, 
      requestTime: myTowDetails.requestTime,
      requestDate: myTowDetails.requestDate,
      latitude: myTowDetails.latitude,
      longitude: myTowDetails.longitude,
      destLatitude: myTowDetails.destLatitude,
      destLongitude: myTowDetails.destLongitude
    );
    scrLat = myTowDetails.latitude;
    scrLong = myTowDetails.longitude;
    destLat = myTowDetails.destLatitude;
    destLong = myTowDetails.destLongitude;
  }

  storeTowingRequest ({TowingModel towingModel}) async {
    FirebaseUser user = await _auth.currentUser();
    try {
      final storeTowingRequest = await _store.collection('towingRequest').document(user.uid).collection('request').document().setData(
        {
        'userid' : user.uid,
        'vehicleid' : towingModel.vehicle + towingModel.requestDate + towingModel.requestTime,
        'country': towingModel.country,
        'state': towingModel.state,
        'lga': towingModel.lga,
        'vehicle': towingModel.vehicle,
        'brand': towingModel.brand,
        'model': towingModel.model,
        'location': towingModel.location,
//        'latitude': towingModel.latitude,
//        'longitude': towingModel.longitude,
        'destination': towingModel.destination,
//        'destLatitude': towingModel.destLatitude,
//        'destLongitude': towingModel.destLongitude,
        'conditionOfVehicle': towingModel.conditionOfVehicle,
        'casualty': towingModel.casualty,
        'additionalInfo': towingModel.additionalInfo,
        'requestTime': towingModel.requestTime,
        'requestDate': towingModel.requestDate,
    });
    request = Request.sent;
    notifyListeners();
    print('successfully');
    return;
  }
    catch (e) {
      print('Something went wrong');
    request = Request.notSent;
    notifyListeners();
    return;
    }
    
  }

}