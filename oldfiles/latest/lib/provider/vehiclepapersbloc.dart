
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehispace/models/vehiclepapers.dart';

enum Status {Sent, NotSent}

class VehiclePaperBloc extends ChangeNotifier {

  static int engineCap1;
  static int engineCap2;
  static int engineCap3;
  static int insuranceRenewComm;
  static int insuranceRenewPriv;
  static int roadWorthinessComm;
  static int roadWorthinessPriv;
  static int deliverycost;

  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _store = Firestore.instance;

  Status _status = Status.NotSent;

  get status => _status;

  set status (val) => _status = val;

  VehiclePapersModel _vehiclePapersModel = VehiclePapersModel();

  get vehiclePaperModel => _vehiclePapersModel;

  set vehiclePaperModel (val) {
    return _vehiclePapersModel = val;
  }

  setVehiclePaperDetails ({VehiclePapersModel vehiclePaperData}) {
      vehiclePaperModel = VehiclePapersModel(
        country: vehiclePaperData.country,
        state: vehiclePaperData.state,
        pin: vehiclePaperData.pin,
        registrationNumber: vehiclePaperData.registrationNumber,
        engineNumber: vehiclePaperData.engineNumber,
        vehicleMake: vehiclePaperData.vehicleMake,
        colour: vehiclePaperData.colour,
        engineCapacity: vehiclePaperData.engineCapacity,
        transactionDate: vehiclePaperData.transactionDate,
        expiryDate: vehiclePaperData.expiryDate,
        dateIssued: vehiclePaperData.dateIssued,
        roadWorthiness: vehiclePaperData.roadWorthiness,
        roadWorthinessType: vehiclePaperData.roadWorthinessType,
        insuranceRenewal: vehiclePaperData.insuranceRenewal,
        insuranceRenewalType: vehiclePaperData.insuranceRenewalType,
        requestTime: vehiclePaperData.requestTime,
        requestDate: vehiclePaperData.requestDate,
        vehicleId: vehiclePaperData.registrationNumber,
        roadWorthinessPrice: vehiclePaperData.roadWorthinessPrice,
        insuranceRenewalPrice: vehiclePaperData.insuranceRenewalPrice,
        vehicleLicensePrice: vehiclePaperData.vehicleLicensePrice,
      );
      notifyListeners();
  }

  storeVehicleRenewalRequest ({VehiclePapersModel vehiclePaperData}) async {
    FirebaseUser user = await _auth.currentUser();
    try {
      final storeVehicleRenewalRequest = await _store.collection('vehiclerenewalrequest').document(user.uid).collection('request').document(vehiclePaperData.registrationNumber).setData(
          {
            'userid' : user.uid,
            'country' : vehiclePaperData.country,
            'state': vehiclePaperData.state,
            'pin': vehiclePaperData.pin,
            'registrationNumber': vehiclePaperData.registrationNumber,
            'engineNumber': vehiclePaperData.engineNumber,
            'vehicleMake' : vehiclePaperData.vehicleMake,
            'colour' : vehiclePaperData.colour,
            'engineCapacity' : vehiclePaperData.engineCapacity,
            'transactionDate' : vehiclePaperData.transactionDate,
            'expiryDate' : vehiclePaperData.expiryDate,
            'dateIssued' : vehiclePaperData.dateIssued,
            'roadWorthiness' : vehiclePaperData.roadWorthiness,
            'roadWorthinessType' : vehiclePaperData.roadWorthinessType,
            'insuranceRenewal': vehiclePaperData.insuranceRenewal,
            'insuranceRenewalType': vehiclePaperData.insuranceRenewalType,
            'requestTime' : vehiclePaperData.requestTime,
            'requestDate' : vehiclePaperData.requestDate,
            'vehicleId' : vehiclePaperData.registrationNumber,
          });
      status = Status.Sent;
      notifyListeners();
      print('successfully');
      return;
    }
    catch (e) {
      print('Something went wrong');
      status = Status.NotSent;
      notifyListeners();
      return;
    }

  }
  
   getPriceList() async {
//    List<dynamic> myPrice = [];
    final eCPrice = await _store.collection('pricelist').document('engineCapacity').get();
    final iRPrice = await _store.collection('pricelist').document('insuranceRenewal').get();
    final rWPrice = await _store.collection('pricelist').document('roadWorthiness').get();
    final delivery = await _store.collection('pricelist').document('deliveryFee').get();
    engineCap1 = eCPrice['1.0 - 2.0'];
    engineCap2 = eCPrice['2.1 - 3.0'];
    engineCap3 = eCPrice['3.1 Above'];
    insuranceRenewPriv = iRPrice['private'];
    insuranceRenewComm = iRPrice['commercial'];
    roadWorthinessPriv = rWPrice['private'];
    roadWorthinessComm = rWPrice['commercial'];
    deliverycost = delivery['delivery'];
  }

  getEngineCapacityprice ({String eCapicityvalue}) {
    int price;
    if (eCapicityvalue == '1.0 - 2.0') {
      price = engineCap1;
    }
    else if (eCapicityvalue == '2.1 - 3.0') {
      price = engineCap2;
    }
    else {
      price = engineCap3;
    }
    return price;
  }

  getInsuranceRenewalPrice ({String insuranceType}) {
    int price;
    if (insuranceType == 'private') {
      price = insuranceRenewPriv;
    }
    else if (insuranceType == 'commercial') {
      price = insuranceRenewComm;
    }
    return price;
  }

  getRoadWorthinessPrice ({String roadWorthinessType}) {
    int price;
    if (roadWorthinessType == 'private') {
      price = roadWorthinessPriv;
    }
    else if (roadWorthinessType == 'commercial') {
      price = roadWorthinessComm;
    }
    return price;
  }
}