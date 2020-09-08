import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';
import 'package:vehispace/services/state_lga_service.dart';
import 'package:vehispace/widgets/customdropdown.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:intl/intl.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/towingbloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vehispace/models/towingmodel.dart';
import 'package:vehispace/services/location_service.dart';

class TowingInformation extends StatefulWidget {
  final Function onPressed;
  TowingInformation({this.onPressed});
  @override
  _TowingInformationState createState() => _TowingInformationState();
}

class _TowingInformationState extends State<TowingInformation> {
  String vehicle;
  String manufacturer;
  String casaulty;
  String condition;
  String state;
  String lga;
  String vehicleMake;
  String vehicleBrand;
  String destination;
  String addInfo;
  String model;
  String location;
  double latitude;
  double longitude;
  double destLatitude;
  double destLongitude;
  var address = [];
  List stateList =  ['Lagos'];
  List lgaList =  ['Eti Osa'];
  List <String> countrylist =['Nigeria'];
  List <String> conditionlist = ['Damaged', 'Accident'];
  List <String> casaultylist =['Yes', 'No'];
  List<String> vehiclelist = ['Honda', 'Toyota', 'Kia'];
  List<String> manufacturerlist = ['Honda', 'Toyota', 'Kia'];
  TowingModel towingModel = TowingModel();
  bool _saving = false;
  bool check = false;
  final format = DateFormat('KK:mm:a');
  final dformat = DateFormat('dd/MM/yy');
  String country = 'Nigeria';
  // List<dynamic> stateList = FetchStateAndLGA().getStates();
  String x;
  var add;
  var destAdd;
  // Towing page = Towing.Order;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override

  void initState() {
    super.initState();
    AppBarTitle().appBarTitle = 'Towing Information';
      MyVehicleBloc().getVehicles();
  }
  @override

  Widget build(BuildContext context) {
    var towingBloc = Provider.of<TowingBloc>(context);
    var fetchStateLGA = Provider.of<FetchStateAndLGA>(context);
    var vehiceBloc = Provider.of<MyVehicleBloc>(context);
    return
//      ModalProgressHUD(
//       inAsyncCall: _saving,
//        dismissible: false,
//        progressIndicator: Center(
//          child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                CircularProgressIndicator(),
//                SizedBox(height: 10,),
//                Text('Processing Request ...', style: TextStyle(fontFamily: 'Sansation'),),
//              ]
//          ),
//        ),
//          child :
          SafeArea(
            child: Form(
            key: _formkey,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15,5,15,10),
              color: Color(0xffe5e5e5),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                     SizedBox(height: 10,),
                  CustomDropdown(
                    value: country,// ?? towingBloc.towingDetails.casaulty,
                    onChanged: (val){
                        setState(() {
                          country = val;
                        });
                      },
                    items: countrylist,
                    labelText: 'Country'
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomDropdown(
                    value: state,// ?? towingBloc.towingDetails.casaulty,
                    onChanged: (val){
                      print(val);
                        setState(() {
                          state = val;

                          // fetchStateLGA.getLGA(val);
                        });
                      },
                    items: stateList,//FetchStateAndLGA.states, //fetchStateLGA.nigeriaState,//countrylist,
                    labelText: 'State'
                  ),
                  SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomDropdown(
                    value: lga ,//?? towingBloc.towingDetails.casaulty,
                    onChanged: (val){
                        setState(() {
                          lga = val;
                        });
                      },
                      items: FetchStateAndLGA.lagosLGA, //fetchStateLGA.nigeriaLGA, //countrylist,
                      labelText: 'Local Government Area'
                    ),
                      // CustomTextField(
                      //   intialValue: towingBloc.towingDetails.lga,
                      //   hint: 'Local Government Area',
                      //   onSaved: (val) {
                      //    lga = val;
                      //   },
                      //   keyboardType: TextInputType.text,
                      //   validator: (val) {
                      //     if(val.isEmpty){
                      //       return 'LGA is Required';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomDropdown(
                          value: vehicleMake,
                          onChanged: (val){
                            setState(() {
                              vehicleMake = val;
                            });
                          },
                          items: MyVehicleBloc.vehicle,
                          labelText: 'Vehicle Make'
                      ),
//                      CustomTextField(
//                        intialValue: towingBloc.towingDetails.vehicle ?? '',
//                        hint: 'Vehicle Make',
//                        onSaved: (val) {
//                        vehicleMake = val;
//                        },
//                        keyboardType: TextInputType.text,
//                        validator: (val) {
//                          if(val.isEmpty){
//                            return 'Vehicle Make is Required';
//                          }
//                          return null;
//                        },
//                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        intialValue: towingBloc.towingDetails.brand ?? '',
                        hint: 'Brand',
                        onSaved: (val) {
                       vehicleBrand = val;
                        },
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if(val.isEmpty){
                            return 'Brand is Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        intialValue: towingBloc.towingDetails.model,
                        hint: 'Model/Year',
                        onSaved: (val) {
                          model = val;
                        },
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if(val.isEmpty){
                            return 'Model/Year is Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      check ? Text(x) :
                      CustomTextField(
                        hint: 'Location',
                        intialValue: towingBloc.towingDetails.location ?? x ?? '' ,
                        onSaved: (val) {
                          location = val;
                        },
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if(val.isEmpty){
                            return 'Location is Required';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: check,
                            activeColor: Color(0xff003399),
                            checkColor: Color(0xff003399),
                            onChanged: (val) async {
                               print('i was tapped');
                           var loc = await LocationService().userCurrentLocation();
                           print('Latitude &&& Longitude');
                            print('Lat &&& Long  ' + loc.toString());
                            address = await LocationService().getAddressFromLatLng(latLng: Position(
                              latitude: loc.latitude,
                              longitude: loc.longitude,
                            ));
                              setState(() {
                                check = val;
                                latitude = loc.latitude;
                                longitude = loc.longitude;
                                x = address[0].subThoroughfare + ' ' + address[0].thoroughfare + ' ' +  address[0].subLocality + ' ' +  address[0].locality + ' ' + address[0].country;
                              });
                              // print('Address = ' + x);
                              print('From Coordinates');
                              print(latitude.toString());
                              print(longitude.toString());
                            },
                          ),
                          Text('Use my current location'),
                          // RaisedButton(
                          //   child: Text('MEE'),
                          //   onPressed: () async {
                          //     print('i was tapped');
                          //  var loc = await LocationService().getUserContinousLocation();
                          //  print('Latitude &&& Longitude');
                          //   print('Lat &&& Long  ' + loc.toString());
                          //   await LocationService().getAddressFromLatLng(latLng: Position(
                          //     latitude: loc.latitude,
                          //     longitude: loc.longitude,
                          //   ));
                          // }
                          // ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        intialValue: towingBloc.towingDetails.destination ?? '',
                        hint: 'Destination',
                        onSaved: (val) {
                          destination = val;
                        },
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if(val.isEmpty){
                            return 'Destination is Required';
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomDropdown(
                          value: condition,// ?? towingBloc.towingDetails.conditionOfVehicle,
                          onChanged: (val){
                            setState(() {
                              condition = val;
                            });
                          },
                          items: conditionlist,
                          labelText: 'Condition of Vehicle'
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomDropdown(
                          value: casaulty,// ?? towingBloc.towingDetails.casaulty,
                          onChanged: (val){
                            setState(() {
                              casaulty = val;
                            });
                          },
                          items: casaultylist,
                          labelText: 'Casaulty'
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      casaulty == 'Yes' ?
                      CustomTextField(
                        intialValue: towingBloc.towingDetails.additionalInfo ?? '',
                        hint: 'Additional Information',
                        onSaved: (val) {
                          addInfo = val;
                        },
                        keyboardType: TextInputType.text,
                          validator: (val) {
                            if(val.isEmpty){
                              return 'Additional Information is Required';
                            }
                            return null;
                          },
                      )
                      : Container(),

                      _saving ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor: Color(0xff003399),
                          ),
                        ],
                      ) : Container(),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Builder(
                        builder: (context) => SizedBox(
                          width: MediaQuery.of(context).size.width*0.95,
                          height: MediaQuery.of(context).size.height*0.07,
                          child: CustomRaisedButton(
                            onPressed: () async {
                              if(!_formkey.currentState.validate()){
                                return;
                              }
                              if (lga == null) {
                                Fluttertoast.showToast(
                                  msg: 'LGA is empty',
                                  textColor: Colors.black,
                                  gravity: ToastGravity.CENTER,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Color(0xffe5e5e5),
                                  fontSize: 16,
                                );
                                return;
                              }
                              if (vehicleMake == null) {
                                Fluttertoast.showToast(
                                  msg: 'Vehicle Make field is empty',
                                  textColor: Colors.black,
                                  gravity: ToastGravity.CENTER,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Color(0xffe5e5e5),
                                  fontSize: 16,
                                );
                                return;
                              }
                              if (condition == null) {
                                Fluttertoast.showToast(
                                  msg: 'Vehicle condition is empty',
                                  textColor: Colors.black,
                                  gravity: ToastGravity.CENTER,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Color(0xffe5e5e5),
                                  fontSize: 16,
                                );
                                return;
                              }
                              if (casaulty == null) {
                                Fluttertoast.showToast(
                                  msg: 'Casaulty field is empty',
                                  textColor: Colors.black,
                                  gravity: ToastGravity.CENTER,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Color(0xffe5e5e5),
                                  fontSize: 16,
                                );
                                return;
                              }
                               _formkey.currentState.save();
//                              if (check == false) {
//                                add = await LocationService().getLatLngFromAddress(address: location);
//                                latitude = add.latitude;
//                                longitude= add.longitude;
//                              }else {
//                                print('true');
//                              }
//                              destAdd = await LocationService().getLatLngFromAddress(address: destination);
//                                destLatitude = destAdd.latitude;
//                                destLongitude= destAdd.longitude;
                              setState(() {
                                _saving = true;
                              });
                              var towingModel = TowingModel(
//                                  vehicleId: vehicleMake+format.format(DateTime.now()).toString()+dformat.format(DateTime.now()).toString(),
                                  country: country,
                                  state: state,
                                  lga: lga,
                                  vehicle: vehicleMake,
                                  brand: vehicleBrand,
                                  model: model,
                                  location: location ?? x,
                                  latitude: latitude,
                                  longitude: longitude,
                                  destination: destination,
//                                  destLatitude: destLatitude,
//                                  destLongitude: destLongitude,
                                  conditionOfVehicle: condition,
                                  casualty: casaulty,
                                  additionalInfo: addInfo ?? '',
                                  requestTime: format.format(DateTime.now()),
                                  requestDate: dformat.format(DateTime.now()),
                                );
                              towingBloc.setTowingDetails(
                                myTowDetails: towingModel
                              );
//                              await towingBloc.storeTowingRequest(
//                                  towingModel: TowingModel(
//                                    country: country,
//                                    state: state,
//                                    lga: lga,
//                                    vehicle: vehicleMake,
//                                    brand: vehicleBrand,
//                                    model: model,
//                                    location: location ?? x,
//            //                      latitude: towingBloc.towingDetails.latitude,
//            //                      longitude: towingBloc.towingDetails.longitude,
//                                    destination: destination,
//            //                      destLatitude: towingBloc.towingDetails.destLatitude,
//            //                      destLongitude: towingBloc.towingDetails.destLongitude,
//                                    conditionOfVehicle: condition,
//                                    casualty: casaulty,
//                                    additionalInfo: addInfo ?? '',
//                                    requestTime: format.format(DateTime.now()),
//                                    requestDate: dformat.format(DateTime.now()),
//                                  )
//                              );
                             setState(() {
                                _saving = false;
                              });
                              widget.onPressed();
                            },
                            text: 'REQUEST TOWING SERVICE',
                            elevation: 5.0,
                            color: Color(0xff003399),
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}