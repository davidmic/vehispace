import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehispace/models/vehiclemodel.dart';
import 'package:vehispace/widgets/aboutvehicle.dart';
import 'package:vehispace/widgets/notificationcard.dart';
import 'package:vehispace/widgets/vehiclecard.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MaintenanceUpdate extends StatefulWidget {
  final String title;
  MaintenanceUpdate({this.title});
  @override
  _MaintenanceUpdateState createState() => _MaintenanceUpdateState();
}

class _MaintenanceUpdateState extends State<MaintenanceUpdate> {
 
 var carData;
  String lorem =
      'Take the 2010 Toyota Camrys buttery soft ride and roomy, serene cabin, for example, which have been endearing th excellent crash test scores and comfort and refinement to spare, the Camrys got what most family-sedan shoppers want. For 2010, the Camry receives a midcycle rejuvenation. Most notably.';
  String lorem2 =
      'Take the 2010 Toyota Camrys buttery soft ride and roomy, serene cabin, for example, which have been endearing th excellent crash test scores and comfort and refinement to spare,';
  PageController pagecontroller;
  
  String vehicleType;
  String engineType;
  var buildpage = 0;
  int x;
  int lenght = 1;
  Widget v;
  Firestore _store = Firestore.instance;
  List<VehicleModel> myVehicle = [];

  getVehicleDetails (String document) async {
    try{
      final read = await _store.collection('Vehicles').document(document).get();
      print("this is " + read.documentID);
      setState(() {
        carData = read;
      });

      return read;
    }
    catch(e){
      print('update failed');
    }
  }
  @override

  void initState () {
    super.initState();
    setState(() {
      x = 0;
      pagecontroller = PageController (
       initialPage: x
      );
      AppBarTitle().appBarTitle = 'Maintenance Update';
    });
  }

  @override
  Widget build(BuildContext context) {
    var _userProfile = Provider.of<UserProfile>(context);
    var _vehiclebloc = Provider.of<MyVehicleBloc>(context); 
     return StreamBuilder<QuerySnapshot>(
          stream: _store.collection('vehiclemanagement').document(_userProfile.userid).collection('myvehicles').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData){
               return Center(child: CircularProgressIndicator());
          }
            else if (snapshot.hasData){
              final vehicleData = snapshot.data.documents;
//              MyVehicleBloc().userVehicleDetails = vehicleData;
             _vehiclebloc.vehiclesDetails = vehicleData;
                print('In Vehicles Page' + _userProfile.userid);
                return vehicleData.length == 0 ?
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PageView.builder(
//                    physics: ScrollPhysics(),
//                    scrollDirection: Axis.horizontal,
                    controller: pagecontroller,
                    itemCount: lenght,
                    itemBuilder: (context, index) {
                      return ListView(
                       physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          SizedBox(height: 10,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.26,
                        child: VehicleCard(
                          model: 'Model',
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Maintenance Update Not Available', style: TextStyle(fontFamily: 'Sansation', fontSize: 22),),
                          ],
                        ),
                      ),
                      // Text('Register a vehicle'),
                    ]
                  );
                }
              ),
            )
                : 
                buildpage == 0 ? 
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PageView.builder(
//                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: pagecontroller,
                    itemCount: vehicleData.length,
                    itemBuilder: (context, index) {
                      _vehiclebloc.vehicleIndex = index; 
                      return ListView(
//                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: 10,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.26,
                        child: VehicleCard(
                              manufacturer: (vehicleData[index]['manufacturer']) ?? '',
                              model: vehicleData[index]['model'] ?? '',
                              vehicleType: vehicleData[index]['vehicle'] ?? '',
                              engineType: vehicleData[index]['engineType'] ?? '',
                              imageUrl: 
                              // Image.network(vehicleData[index]['imageURL'], fit: BoxFit.fill,),
                              CachedNetworkImage(
                                imageUrl: vehicleData[index]['imageURL'],
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                fit: BoxFit.fill,
                                ),
                              callBack: () {
                               getVehicleDetails(vehicleData[_vehiclebloc.vehicleIndex]['manufacturer']);
                                setState(() {
                                  buildpage = 1;
                                });
                              },
                            ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      Container(
                        alignment: Alignment.center,
                        child: DotsIndicator(
                          dotsCount: vehicleData.length ?? 0,
                          position: index.toDouble(),
                          decorator: DotsDecorator(
                            color: Colors.grey.withOpacity(0.3),
                            size: vehicleData.length == 1 ?  Size(0.0, 0.0) : Size(25.0, 10.0),
                            activeSize: vehicleData.length == 1 ?  Size(0.0, 0.0) : Size(25.0, 10.0),
                            activeColor: Color(0xff003399),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                    ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      
                      StreamBuilder<QuerySnapshot>(
                        stream: _store.collection('generalweeklytips').snapshots(),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData) {
                            return Center(child: Text('No Maintenance Tips'),);
                          } else if (snapshot.hasData) {
                            var update = snapshot.data.documents;
                            return ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: update.length,
                                itemBuilder: (context, snapshot){
                                  final updateContent = update;
                                  return NotifcationCard(
                                    title: updateContent[snapshot]['title'] ?? '',
                                    titleBody: updateContent[snapshot]['body'],
                                    fullBody: updateContent[snapshot]['body'],
//                                    showRead: true,
                                    dateTime: '23/04/20',
                                  );
                                }
                            );
                          }
                        }
                      ),   
                ]
        );
      },         
    ),
   ): MoreDetailsVehicle(
      manufacturer: vehicleData[_vehiclebloc.vehicleIndex]['manufacturer'] ?? '',
      model: vehicleData[_vehiclebloc.vehicleIndex]['model'] ?? '',
      vehicleType: vehicleData[_vehiclebloc.vehicleIndex]['vehicle'] ?? '',
      engineType: vehicleData[_vehiclebloc.vehicleIndex]['engineType'] ?? '',
      content: carData['vehicle'] ?? '',
      imageURL: CachedNetworkImage(
        imageUrl: vehicleData[_vehiclebloc.vehicleIndex]['imageURL'],
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        fit: BoxFit.fill,
        ),
        closeCallback: (){
          setState(() {
            buildpage = 0;
          });
        },
    );
  }
            
}

);
  }
}

