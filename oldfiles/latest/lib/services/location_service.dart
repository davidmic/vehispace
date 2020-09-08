import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  Position position;

 userCurrentLocation () async {
   final GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
     Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best); 
     print (position);
     print (position.latitude);
    print (position.longitude);
    print (position.accuracy);
    print (position.timestamp);
    print (position.speed);
    print (position.speedAccuracy);
    print (position.heading);
     return position;
   }
  

  userLastLocation () async {
   final GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.best);
    print (position.latitude);
    print (position.longitude);
    print (position.accuracy);
    print (position.timestamp);
    print (position.speed);
    print (position.speedAccuracy);
    print (position.heading);
     return position;
   
  }
  
  getUserContinousLocation () async {
    final GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
    print (geolocationStatus.toString());
    StreamSubscription<Position> positionStream = Geolocator().getPositionStream(LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 10)).listen((position){
        print (position == null ? 'Unknown' : 'We have Postion');
        print (position.latitude);
        print (position.longitude);
        print (position.accuracy);
        print (position.timestamp);
        print (position.speed);
        print (position.speedAccuracy);
        print (position.heading);
        return position;
    }); 
  }

  getLatLngFromAddress ({String address}) async {
    List<Placemark> placemark = await Geolocator().placemarkFromAddress(address);
    print(placemark[0].position);
    return placemark[0].position;
  }
  getAddressFromLatLng ({Position latLng}) async {
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    print(placemark.length); 
    // print(placemark[0].country.toString());
    // print(placemark[0].name);
    // print(placemark[0].administrativeArea);
     print(placemark[0].locality);
    //  print(placemark[0].position);
    //  print(placemark[0].subAdministrativeArea);
     print(placemark[0].subLocality);
     print(placemark[0].subThoroughfare);
     print(placemark[0].thoroughfare);
    // print(placemark[0].postalCode.toString());
    print(placemark[0].isoCountryCode.toString());
    return placemark;
  }

  calculateDistance (LatLng sourceLocation, LatLng destinationLocation) async {
    double distanceInMeters = await Geolocator().distanceBetween(sourceLocation.latitude, sourceLocation.longitude, destinationLocation.latitude, destinationLocation.longitude);
    return distanceInMeters;
  }
   List <Map<String, dynamic>> xlist = [
     {
       'Location' : 'Agege',
       'LatLng' : LatLng(6.6152237, 3.3034298)
     },
     {
       'Location' : 'Alausa',
       'LatLng' : LatLng(6.6218151, 3.3567471)
     },
     {
       'Location' : 'Adekunle/Mainland',
       'LatLng' : LatLng(6.4873581, 3.3679027)
     },
     {
       'Location' : 'Ajah',
       'LatLng' : LatLng(6.4637314, 3.5331661)
     },
     {
       'Location' : 'Anthony',
       'LatLng' : LatLng(6.463711, 3.4280944)
     },
     {
       'Location' : 'Cele/Ikotun',
       'LatLng' : LatLng(6.564003, 3.2535356)
     },
     {
       'Location' : 'Costain',
       'LatLng' : LatLng(6.4594242, 3.2048207)
     },
     {
       'Location' : 'Gbagada',
       'LatLng' : LatLng(6.5569355, 3.381713)
     },
     {
       'Location' : 'Ikeja',
       'LatLng' : LatLng(6.6051137, 3.3327517)
     },
     {
       'Location' : 'Ikorodu',
       'LatLng' : LatLng(6.6051137, 3.454467)
     },
     {
       'Location' : 'Ladipo',
       'LatLng' : LatLng(6.5383403, 3.3437686)
     },
     {
       'Location' : 'Mile 2',
       'LatLng' : LatLng(6.4659336, 3.3176028)
     },
     {
       'Location' : 'Moshalashi',
       'LatLng' : LatLng(6.610188, 3.2915211)
     },
     {
       'Location' : 'Obalande',
       'LatLng' : LatLng(6.4463603, 3.404485)
     },
     {
       'Location' : 'Okoko',
       'LatLng' : LatLng(6.4741721, 3.176361)
     },
     {
       'Location' : 'Owodo',
       'LatLng' : LatLng(6.5029822, 3.3892884)
     },
     {
       'Location' : 'Oworo',
       'LatLng' : LatLng(6.6549564, 3.3995669)
     },
     {
       'Location' : 'Super',
       'LatLng' : LatLng(6.5897463, 3.2289833)
     },
     {
       'Location' : 'Wharf 1',
       'LatLng' : LatLng(6.4530631, 3.3645287)
     },
     {
       'Location' : 'Wharf 2',
       'LatLng' : LatLng(6.64536215, 3.364964)
     },
     {
       'Location' : 'Toll Gate',
       'LatLng' : LatLng(6.599437, 3.3756053)
     },
   ];

    List<LatLng> listDestinationCoordinates = [
      LatLng(2.0, 3.4),
      LatLng(2.0, 3.4),
      LatLng(2.0, 3.4),
      LatLng(2.0, 3.4),
    ];
    LatLng currentPosition = LatLng(2.1, 3.3);
    double tempDistance;
    double destinationDistance;
    LatLng destinationCoord;

    double distanceBtw () {
      for (var x in listDestinationCoordinates) {
        tempDistance = calculateDistance(currentPosition, x);
        print(tempDistance.toString());
        if (destinationDistance == null ) {
          destinationDistance = tempDistance;
          destinationCoord = x;
        }else if (tempDistance < destinationDistance) {
          destinationDistance = tempDistance;
          destinationCoord = x;
        } else {
          print ('Distance is greater than previous');
        }
      }
    }
}