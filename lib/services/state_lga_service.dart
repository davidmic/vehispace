import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FetchStateAndLGA extends ChangeNotifier{
 static List<dynamic> nigerianStates = [];
 static List<dynamic> nigerianLGA = [];

get nigeriaState => nigerianStates;
get nigeriaLGA => nigerianLGA;

set nigeriaState (List<dynamic> val) => nigerianStates = val;
set nigeriaLGA (List<dynamic> val) => nigerianLGA = val;

  String stateURL = 'http://locationsng-api.herokuapp.com/api/v1/states';
  
  getStates () async {
    http.Response jsonStates = await http.get(stateURL);
    List d = [];
    print(jsonStates.statusCode);
    if (jsonStates.statusCode == 200) {
      var mapStates = jsonDecode(jsonStates.body);
      // print(mapStates);
      // var listOfState = mapStates[0];
      mapStates.forEach((v){
        String f = v['name'];
        // print(f);
        // nigerianStates.add(f);
         d.add(f);
      });
      nigerianStates = d;
      notifyListeners();
      print('the states');
      print(nigerianStates);
    }
    // print(d);
    return d;
  }

 getLGA (String state) async {
   http.Response lga = await http.get('http://locationsng-api.herokuapp.com/api/v1/states/$state/lgas');
   var lgalist = [];
   if(lga.statusCode == 200) {
     lgalist = jsonDecode(lga.body);
     print(lgalist);
   }
   nigerianLGA = lgalist;
   notifyListeners();
   return lgalist;
 }
 static List <String> states = [
    'Abia',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Enugu',
    'Edo',
    'Ekiti',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
 ];

 static Map<String, dynamic> lGA =
 {
     'Lagos' : ['Agege',
       'Alimosho Ifelodun',
       'Alimosho',
       'Amuwo-Odofin',
       'Apapa',
       'Badagry',
       'Epe',
       'Eti-Osa',
       'Ibeju- Lekki',
       'Ifako/Ijaye', 'Ikeja',
       'Ikorodu',
       'Kosofe',
       'Lagos Island',
       'Lagos Mainland',
       'Mushin',
       'Ojo',
       'Oshodi -Isolo',
       'Shomolu',
       'Surulere',
     ],

     'Abuja' : [
       'Gwagwalada',
       'Kuje',
       'Abaji',
       'Abuja Municipal',
       'Bwari',
       'Kwali',
     ],

     'Oyo' : [
       'Afijio',
       'Akinyele',
       'Atiba',
       'Atigbo',
       'Egbeda',
       'Ibadan Central',
       'Ibadan North',
       'Ibadan North West',
       'Ibadan South East',
       'Ibadan South West',
       'Ibarapa Central',
       'Ibarapa East',
       'Ibarapa North',
       'Ido',
       'Irepo',
       'Iseyin',
       'Itesiwaju',
       'Iwajowa',
       'Kajola',
       'Lagelu Ogbomosho North',
       'Ogbmosho South',
       'Ogo Oluwa',
       'Olorunsogo',
       'Oluyole',
       'Ona-Ara',
       'Orelope',
       'Ori Ire',
       'Oyo East',
       'Oyo West',
       'Saki East',
       'Saki West',
       'Surulere',
     ],

     'Osun' : [
       'Aiyedade',
       'Aiyedire',
       'Atakumosa East',
       'Atakumosa West',
       'Boluwaduro',
       'Boripe',
       'Ede North',
       'Ede South',
       'Egbedore',
       'Ejigbo',
       'Ife Central',
       'Ife East',
       'Ife North',
       'Ife South',
       'Ifedayo',
       'Ifelodun',
       'Ila',
       'Ilesha East',
       'Ilesha West',
       'Irepodun',
       'Irewole',
       'Isokan',
       'Iwo',
       'Obokun',
       'Odo-Otin',
       'Ola-Oluwa',
       'Olorunda',
       'Oriade',
       'Orolu',
       'Osogbo',
     ],
   };
}