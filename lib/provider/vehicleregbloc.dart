import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehispace/models/vehiclemodel.dart';

enum Vehicle {uninitialized, successful,failed}

class MyVehicleBloc extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _store = Firestore.instance;
  Vehicle _status = Vehicle.uninitialized;
  static String message;
  int _vehicleIndex;
  static List<dynamic> vehicle = [];
  List<dynamic> _vehiclesDetails = [];
  static List<dynamic> allVehicle = [];
  static List<dynamic> model = [];

  List<dynamic> get vehiclesDetails => _vehiclesDetails;

  set vehiclesDetails (List<dynamic> val) => _vehiclesDetails = val;

  Vehicle get status => _status;

  int get vehicleIndex => _vehicleIndex;

  set vehicleIndex (int val) => _vehicleIndex = val; 

  set status (Vehicle val) => _status = val;

//  List<DocumentSnapshot> _userVehicleDetails = [];
//  get userVehicleDetails => _userVehicleDetails;
//  set userVehicleDetails (value) => _userVehicleDetails = value;

  Future addVehicle ({@required VehicleModel vehicleModel}) async {
    try {
      final user = await _auth.currentUser();
      final vehicle = await _store.collection('vehiclemanagement').document(user.uid).collection('myvehicles').document(vehicleModel.regNo).setData({
        'userId' : user.uid,
        'vehicleId' : user.uid+vehicleModel.regNo,
        'vehicle' : vehicleModel.vehicleType,
        'manufacturer' : vehicleModel.manufacturer,
        'model' : vehicleModel.model,
        'year' : vehicleModel.year,
        'registrationNumber' : vehicleModel.regNo,
        'engineType' : vehicleModel.engineType,
        'engineNumber' : vehicleModel.engineNo,
        'engineCapacity' : vehicleModel.engineCapacity,
        'imageURL' : vehicleModel.imageURL,
        'dateOfLastServie' : vehicleModel.dateOfLastService,
        'milleage' : vehicleModel.millege,
        'creatdDate' : vehicleModel.createdDate,
        'userToken' : vehicleModel.userToken,
      });
      final mergeUserToVehicle = await _store.collection('Vehicles').document(vehicleModel.manufacturer).collection('user').document(user.uid).setData({
        'userId' : user.uid,
        'userToken' : vehicleModel.userToken,
      });
      status = Vehicle.successful;
      print('vehicle added successfully');
      notifyListeners();
    } catch (e) {
      message = (e.code.toString().replaceAll("_", " "));
      print(e.toString());
      status = Vehicle.failed;
      notifyListeners();
    }
  }

  Future upadteUserVehicleDetails({@required VehicleModel vehicleModel}) async {
    try {
       final user = await _auth.currentUser();
      final vehicle = await _store.collection('vehiclemanagement').document(user.uid).collection('myvehicles').document(vehicleModel.regNo).updateData({
        'vehicle' : vehicleModel.vehicleType,
        'manufacturer' : vehicleModel.manufacturer,
        'model' : vehicleModel.model,
        'registrationNumber' : vehicleModel.regNo,
        'engineNumber' : vehicleModel.engineNo,
        'engineCapacity' : vehicleModel.engineCapacity,
      });
      status = Vehicle.successful;
      print('Updated successfully');
      notifyListeners();
    } catch (e) {
      message = e.code.toString().replaceAll("_", " ");
      print (message);
    }
    
  }


  
  getVehicles () async {
    final x = await _store.collection('Vehicles').document('listofvehicles').get();
    vehicle = x['vehicles'];
    print(x['vehicles']);
//    var vehicle = x.then((value) => print(value.documents[0]['vehicle']));
  }

   List<dynamic> x (String vehicle) {
    var Car = [];
    var Model = [];
      allVehicle.forEach((element) {
        if (element['Make'] == vehicle) {
          Car.add(element);
        }
     });
    Car.forEach((element) {
      if (Model.contains(element['Model'])) {
        print('already in list');
      }
      else {
        Model.add(element['Model']);
        print('Added');
      }
    });
    print(Model.toString());
    model = Model;
//     debugPrint(Car['Model'].toString(), wrapWidth: 20);
     return Car;
   }
}

//List<String> veh = [
//  'Acura',
//  'Alfa Romeo',
//  'Audi',
//  'BMW',
//  'Bentley',
//  'Buick',
//  'Cadillac',
//  'Chevrolet',
//  'Chrysler',
//  'Citroen',
//  'Dacia',
//  'Daewoo',
//  'Dodge',
//  'Fiat',
//  'Ford',
//  'GMC',
//  'Geely',
//  'Honda',
//  'Hyundai',
//  'Infinity',
//  'Jaguar',
//  'Jeep',
//  'Kia',
//  'Land Rover',
//  'Lexus',
//  'Mahindra',
//  'Mazda',
//  'Mercedes',
//  'MercedesBenz',
//  'Mini',
//  'Mitsubishi',
//  'Nissan',
//  'Ople',
//  'Peugeot',
//  'Polester',
//  'RAM',
//  'Renault',
//  'Rolls Royce',
//  'SAAB',
//  'Skoda',
//  'Subaru',
//  'Suzuki',
//  'Tata',
//  'Toyota',
//  'Vauxhall',
//  'VolksWagen',
//  'Volvo',
//  'Others',
//];