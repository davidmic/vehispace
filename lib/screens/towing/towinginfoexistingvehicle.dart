import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';
import 'package:vehispace/services/state_lga_service.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/customdropdown.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:intl/intl.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/towingbloc.dart';
import 'package:vehispace/models/towingmodel.dart';
import 'package:vehispace/services/location_service.dart';

class TowingInformationExistingVehicle extends StatefulWidget {
  final Function onPressed;
  final Function onBack;
  int index;
  TowingInformationExistingVehicle({this.onPressed, this.index, this.onBack});
  @override
  _TowingInformationExistingVehicleState createState() => _TowingInformationExistingVehicleState();
}

class _TowingInformationExistingVehicleState extends State<TowingInformationExistingVehicle> {
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
  String year;
  var address = [];
  List stateList =  ['Lagos','Abuja','Oyo','Osun'];
  List <String> countrylist =['Nigeria'];
  List <String> conditionlist = ['Damaged', 'Immobile', 'Accidental'];
  List <String> casaultylist =['Yes', 'No'];
  List<String> vehiclelist = ['SUV', 'Sedan', 'Others'];

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
//    MyVehicleBloc().getVehicles();
  }
  @override

  Widget build(BuildContext context) {
    var towingBloc = Provider.of<TowingBloc>(context);
    var fetchStateLGA = Provider.of<FetchStateAndLGA>(context);
    var vehiceBloc = Provider.of<MyVehicleBloc>(context);
    print(widget.index);
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
//                    SizedBox(height: 10,),
//                    CustomDropdown(
//                        value: country,// ?? towingBloc.towingDetails.casaulty,
//                        onChanged: (val){
//                          setState(() {
//                            country = val;
//                          });
//                        },
//                        items: countrylist,
//                        labelText: 'Country'
//                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      vehiceBloc.vehiclesDetails[widget.index]['manufacturer'] + " " + vehiceBloc.vehiclesDetails[widget.index]['model'] + " " + vehiceBloc.vehiclesDetails[widget.index]['year'],
                      style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontSize: 18),
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
                            lga = null;
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
                        items: FetchStateAndLGA.lGA[state] ?? [], //fetchStateLGA.nigeriaLGA, //countrylist,
                        labelText: 'Local Government Area'
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
                            if (state == null) {
                              Fluttertoast.showToast(
                                msg: 'State is empty',
                                textColor: Colors.black,
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Color(0xffe5e5e5),
                                fontSize: 16,
                              );
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
                            if(!_formkey.currentState.validate()){
                              return;
                            }
                            _formkey.currentState.save();
                            setState(() {
                              _saving = true;
                            });
                            var towingModel = TowingModel(
//                                  vehicleId: vehicleMake+format.format(DateTime.now()).toString()+dformat.format(DateTime.now()).toString(),
                              country: country ?? 'Nigeria',
                              state: state,
                              lga: lga,
                              vehicle: vehiceBloc.vehiclesDetails[widget.index]['manufacturer'],
                              model: vehiceBloc.vehiclesDetails[widget.index]['model'],
                              year: vehiceBloc.vehiclesDetails[widget.index]['year'],
                              location: location ?? x,
                              latitude: latitude,
                              longitude: longitude,
                              destination: destination,
                              conditionOfVehicle: condition,
                              casualty: casaulty,
                              additionalInfo: addInfo ?? '',
                              requestTime: format.format(DateTime.now()),
                              requestDate: dformat.format(DateTime.now()),
                            );
                            towingBloc.setTowingDetails(
                                myTowDetails: towingModel
                            );
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
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Go Back',
                            style: Constants.redText,
                          ),
                          onPressed: () {
                            widget.onBack();
                          },
                        ),
                      ],
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