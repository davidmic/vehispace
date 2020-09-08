import 'package:flutter/material.dart';
import 'package:vehispace/models/towingmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Request { sent, notSent }

class TowingBloc extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _store = Firestore.instance;

  TowingModel _towingDetails = TowingModel(
//    country: '',
//    state: '',
//    lga: '',
//    vehicle: '',
//    brand: '',
//    model: '',
//    destination: '',
//    conditionOfVehicle: '',
//    casualty: '',
//    additionalInfo: '',
//    requestTime: '',
//    requestDate: '',
      );
  static double scrLat;
  static double scrLong;
  static LatLng location;
  static double destLat;
  static double destLong;

  Request _request = Request.notSent;

  //request
  get request => _request;
  set request(val) => _request = val;

  //towingdetails
  get towingDetails => _towingDetails;
  set towingDetails(TowingModel val) => _towingDetails = val;

  //scrlocatiionlattitude
  get scrlong => scrLong;
  set scrlong(double val) => scrLong = val;

  //scrlocation longitude
  get scrlat => scrLat;
  set scrlat(double val) => scrLat = val;

  //destlocatiionlattitude
  get destlong => destLong;
  set destlong(double val) => destLong = val;

  //destlocation longitude
  get destlat => destLat;
  set destlat(double val) => destLat = val;

  setTowingDetails({TowingModel myTowDetails}) {
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
      destLongitude: myTowDetails.destLongitude,
      year: myTowDetails.year,
    );
    scrLat = myTowDetails.latitude;
    scrLong = myTowDetails.longitude;
    destLat = myTowDetails.destLatitude;
    destLong = myTowDetails.destLongitude;
    if (myTowDetails.state == 'Lagos') {
      location = LatLng(6.465422, 3.406448);
    }
    else if (myTowDetails.state == 'Abuja'){
      location = LatLng(9.0546462,7.2542657);
    }
    else if (myTowDetails.state == 'Oyo'){
      location = LatLng(7.3758308,3.8586688);
    }
    else if (myTowDetails.state == 'Osun'){
      location = LatLng(7.7801147,4.5424163);
    }
    else {
      location = LatLng(6.465422, 3.406448);
    }
  }

  storeTowingRequest({TowingModel towingModel}) async {
    FirebaseUser user = await _auth.currentUser();
    try {
      final storeTowingRequest = await _store
          .collection('towingRequest')
          .document(user.uid)
          .collection('request')
          .document(
            user.uid + towingModel.location + towingModel.requestTime,
          )
          .setData({
        'userid': user.uid,
        'vehicleid': user.uid + towingModel.location + towingModel.requestTime,
        'country': towingModel.country,
        'state': towingModel.state,
        'lga': towingModel.lga,
        'vehicle': towingModel.vehicle,
//        'brand': towingModel.brand,
        'model': towingModel.model,
        'year': towingModel.year,
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
        'requestStatus': 'processing',
        'cost': 0,
        'userToken': towingModel.userToken,
      });
      request = Request.sent;
      notifyListeners();
      print('successfully');
      return;
    } catch (e) {
      print('Something went wrong');
      request = Request.notSent;
      notifyListeners();
      return;
    }
  }

  List<Map<String, dynamic>> xList = [
    {
      'Location': 'Agege Towing Station',
      'LatLng': LatLng(6.6152237, 3.3034298),
      'Contact': 'Contact: 08028112199'
    },
    {
      'Location': 'Alausa Towing Station',
      'LatLng': LatLng(6.6218151, 3.3567471),
      'Contact': 'Contact: 08023395140'
    },
    {
      'Location': 'Adekunle/Mainland Towing Station',
      'LatLng': LatLng(6.4873581, 3.3679027),
      'Contact': 'Contact: 08139357869'
    },
    {
      'Location': 'Ajah Towing Station',
      'LatLng': LatLng(6.4637314, 3.5331661),
      'Contact': 'Contact: 08023910264'
    },
    {
      'Location': 'Anthony Towing Station',
      'LatLng': LatLng(6.463711, 3.4280944),
      'Contact': 'Contact: 08023137499'
    },
    {
      'Location': 'Cele/Ikotun Towing Station',
      'LatLng': LatLng(6.564003, 3.2535356),
      'Contact': 'Contact: 08023596265'
    },
    {
      'Location': 'Costain Towing Station',
      'LatLng': LatLng(6.4594242, 3.2048207),
      'Contact': 'Contact: 08023694943',
    },
    {
      'Location': 'Gbagada Towing Station',
      'LatLng': LatLng(6.5569355, 3.381713),
      'Contact': 'Contact: 08023425510',
    },
    {
      'Location': 'Ikeja Towing Station',
      'LatLng': LatLng(6.6051137, 3.3327517),
      'Contact': 'Contact: 08062888719',
    },
    {
      'Location': 'Ikorodu Towing Station',
      'LatLng': LatLng(6.6051137, 3.454467),
      'Contact': 'Contact: 08025604956',
    },
    {
      'Location': 'Ladipo Towing Station',
      'LatLng': LatLng(6.5383403, 3.3437686),
      'Contact': 'Contact: 08023820187',
    },
    {
      'Location': 'Mile 2 Towing Station',
      'LatLng': LatLng(6.4659336, 3.3176028),
      'Contact': 'Contact: 08071689941',
    },
    {
      'Location': 'Moshalashi Towing Station',
      'LatLng': LatLng(6.610188, 3.2915211),
      'Contact': 'Contact: 08034224718',
    },
    {
      'Location': 'Obalande Towing Station',
      'LatLng': LatLng(6.4463603, 3.404485),
      'Contact': 'Contact: 08035192112',
    },
    {
      'Location': 'Okoko Towing Station',
      'LatLng': LatLng(6.4741721, 3.176361),
      'Contact': 'Contact: 08089808204',
    },
    {
      'Location': 'Owodo Towing Station',
      'LatLng': LatLng(6.5029822, 3.3892884),
      'Contact': 'Contact: 08162014399',
    },
    {
      'Location': 'Oworo Towing Station',
      'LatLng': LatLng(6.6549564, 3.3995669),
      'Contact': 'Contact: 08032404051',
    },
    {
      'Location': 'Super Towing Station',
      'LatLng': LatLng(6.5897463, 3.2289833),
      'Contact': 'Contact: 08032167056',
    },
    {
      'Location': 'Wharf 1 Towing Station',
      'LatLng': LatLng(6.4530631, 3.3645287),
      'Contact': 'Contact: 08033306089',
    },
    {
      'Location': 'Wharf 2 Towing Station',
      'LatLng': LatLng(6.64536215, 3.364964),
      'Contact': 'Contact: 08023436343',
    },
    {
      'Location': 'Toll Gate Towing Station',
      'LatLng': LatLng(6.599437, 3.3756053),
      'Contact': 'Contact: 08035641046',
    },
      //ABUJA STATE
    {
      'Location': 'Mabushi Towing Station',
      'LatLng': LatLng(
        9.0799343,
        7.4552308,
      ),
      'Contact': 'Contact 08105662040',
    },
    {
      'Location': 'Wuse Zone 4 Towing Station',
      'LatLng': LatLng(9.065223, 7.4668226),
      'Contact': 'Contact 08033141910',
    },
    {
      'Location': 'Gwarinpa Towing Station',
      'LatLng': LatLng(9.1038889, 7.3638406),
      'Contact': 'Contact 08035056846, 08036369190',
    },
    {
      'Location': 'Jabi Towing Station',
      'LatLng': LatLng(9.0640348, 7.4049329),
      'Contact': '',
    },
    {
      'Location': 'Nicon Junction Towing Station',
      'LatLng': LatLng(9.0957822, 7.4578015),
      'Contact': '',
    },
    {
      'Location': 'Aya Junction Towing Station',
      'LatLng': LatLng(9.0493413, 7.524476),
      'Contact': '',
    },
    {
      'Location': 'Kugbo Towing Station',
      'LatLng': LatLng(9.0263751, 7.5405157),
      'Contact': '',
    },
    {
      'Location': 'Apo Nepa Towing Station',
      'LatLng': LatLng(8.9994165, 7.4873546),
      'Contact': '',
    },
    {
      'Location': 'Kubasa Towing Station',
      'LatLng': LatLng(8.9705933, 7.4230275),
      'Contact': '',
    },
    {
      'Location': 'Zuba Towing Station',
      'LatLng': LatLng(9.1055567, 7.1593223),
      'Contact': '',
    },
    {
      'Location': 'Gwagwalada Towing Station',
      'LatLng': LatLng(8.94235, 7.0430273),
      'Contact': '',
    },
    {
      'Location': 'Abaji Towing Station',
      'LatLng': LatLng(8.4754919, 6.9367504),
      'Contact': '',
    },
    {
      'Location': 'Kuje Towing Station',
      'LatLng': LatLng(8.8873715, 7.0859946),
      'Contact': '',
    },
    {
      'Location': 'Bwari Towing Station',
      'LatLng': LatLng(9.2857413, 7.3365274),
      'Contact': '',
    },
    {
      'Location': 'Kubwa Towing Station',
      'LatLng': LatLng(9.1557338, 7.302896),
      'Contact': '',
    },
    {
      'Location': 'Utako Towing Station',
      'LatLng': LatLng(9.0688074, 7.4353573),
      'Contact': 'Contact: 08131111745',
    },
    {
      'Location': 'Area 3 Towing Station',
      'LatLng': LatLng(9.0302426, 7.469759),
      'Contact': 'Contact: 08055433977',
    },
    {
      'Location': 'Area 1 Towing Station',
      'LatLng': LatLng(9.0205574,7.4449108),
      'Contact': 'Contact: 08039298392, 07034822751',
    },
    // OYO STATE
    {
      'Location': 'Iyaganku Towing Station',
      'LatLng': LatLng(7.3758308,3.8586688),
      'Contact': 'Contact: 08033485815',
    },
    //OSUN STATE
    {
      'Location': 'Alekuwodo - Osogbo Towing Station',
      'LatLng': LatLng(7.7801147,4.5424163),
      'Contact': '',
    },
  ];

}
