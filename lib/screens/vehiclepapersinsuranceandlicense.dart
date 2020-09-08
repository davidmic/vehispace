import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/vehiclepapers.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/vehiclepapersbloc.dart';
import 'package:vehispace/services/state_lga_service.dart';
import 'package:vehispace/widgets/datepicker.dart';
import '../utils/constants.dart';
import '../widgets/customdropdown.dart';
import '../widgets/customtextformfield.dart';
import '../widgets/customraisedbutton.dart';
import 'package:intl/intl.dart';


class VehiclePapersInsuranceAndLicense extends StatefulWidget {
  final Function onPressed;
  VehiclePapersInsuranceAndLicense({this.onPressed});
  @override
  _VehiclePapersInsuranceAndLicenseState createState() => _VehiclePapersInsuranceAndLicenseState();
}

class _VehiclePapersInsuranceAndLicenseState extends State<VehiclePapersInsuranceAndLicense> {
//  Completer<GoogleMapController> _controller = Completer();
  String pin;
  String registrationNo;
  String engineNo;
  String vehicleMake;
  String colour;
  String engineCapacity;
  DateTime transDate;
  DateTime expiryDate;
  DateTime dateIssued;
  String roadWorthiness;
  String insuranceRenewal;

  List <String> roadWorthinesslist =['Yes', 'No'];

  List <String> insurancelist =['Yes', 'No'];

  List<String> vehiclelist = ['Honda', 'Toyota', 'Kia'];

  List<String> manufacturerlist = ['Honda', 'Toyota', 'Kia'];

  List<String> engineCapacityList = ['1.0 - 2.0', '2.1 - 3.0', '3.1 Above'];

  String country = 'Nigeria';
  String state;
  String roadWorthinessType;
  String insuranceRenewalType;

  List<String> countrylist = ['Nigeria'];

  List<String> statelist = ['Lagos'];

  final format = DateFormat('KK:mm:a');
  final dformat = DateFormat('dd/MM/yy');

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState () {
    super.initState();
    AppBarTitle().appBarTitle = 'Vehicle Papers';
    VehiclePaperBloc().getPriceList();
  }

  @override
  Widget build(BuildContext context) {
    var vehiclePaperBloc = Provider.of<VehiclePaperBloc>(context);
    var fetchStateLGA = Provider.of<FetchStateAndLGA>(context);
    return Form(
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
                    value: country, //?? towingBloc.towingDetails.casaulty,
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
                    value: state, //?? towingBloc.towingDetails.casaulty,
                    onChanged: (val){
                      print(val);
                      setState(() {
                        state = val;
                      });
                    },
                    items: FetchStateAndLGA.states,//statelist,//countrylist,
                    labelText: 'State'
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  intialValue: vehiclePaperBloc.vehiclePaperModel.pin ?? '',
                  hint: 'Pin',
                  onSaved: (val) {
                    pin = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Pin is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  intialValue: vehiclePaperBloc.vehiclePaperModel.registrationNumber ?? '',
                  hint: 'Registration Number',
                  onSaved: (val) {
                    registrationNo = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Registration Number is Required';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  intialValue: vehiclePaperBloc.vehiclePaperModel.engineNumber,
                  hint: 'Engine Number',
                  onSaved: (val) {
                    engineNo = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Engine Number is Required';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  intialValue: vehiclePaperBloc.vehiclePaperModel.vehicleMake ?? '',
                  hint: 'Vehicle Make',
                  onSaved: (val) {
                    vehicleMake = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Vehicle Make is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  intialValue: vehiclePaperBloc.vehiclePaperModel.colour ?? '',
                  hint: 'Colour',
                  onSaved: (val) {
                    colour = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Field is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
//                CustomDropdown(
//                    value: engineCapacity, //?? towingBloc.towingDetails.casaulty,
//                    onChanged: (val){
//                      print(val);
//                      setState(() {
//                        engineCapacity = val;
//                      });
//                    },
//                    items: engineCapacityList,//countrylist,
//                    labelText: 'Engine Capacity'
//                ),
//            CustomTextField(
//              intialValue: vehiclePaperBloc.vehiclePaperModel.engineCapacity,
//              hint: 'Engine Capacity',
//              onSaved: (val) {
////            lastName = val;
//              },
//              keyboardType: TextInputType.text,
//              validator: (val) {
//                if(val.isEmpty){
//                  return 'Field is Required';
//                }
//                return null;
//              },
//            ),
//                SizedBox(
//                  height: MediaQuery.of(context).size.height * 0.02,
//                ),
                MyDatePicker(
//              initialValue: vehiclePaperBloc.vehiclePaperModel.transactionDate ?? '',
                  customFormat: dformat,
                  hintText: 'Transaction Date',
                  labelText: 'Transaction Date',
                  onSaved: (val) {
                    transDate = val;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                MyDatePicker(
//              initialValue: vehiclePaperBloc.vehiclePaperModel.dateIssued,
                  customFormat: dformat,
                  hintText: 'Date Issued',
                  labelText: 'Date Issued',
                  onSaved: (val) {
                    dateIssued = val;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                MyDatePicker(
//              initialValue: vehiclePaperBloc.vehiclePaperModel.expiryDate,
                  customFormat: dformat,
                  hintText: 'Expiry Date',
                  labelText: 'Expiry Date',
                  onSaved: (val) {
                    expiryDate = val;
                  },

                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomDropdown(
                    value: roadWorthiness,
                    onChanged: (val){
                      setState(() {
                        roadWorthiness = val;
                      });
                    },
                    items: roadWorthinesslist,
                    labelText: 'Road Worthiness Renewal'
                ),
                roadWorthiness == 'Yes' ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: RadioListTile(
                        activeColor: Color(0xff003399),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text('Private', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sansation', fontStyle: FontStyle.normal,),),
                        onChanged: (val){
                          setState(() {
                            roadWorthinessType = val;
                          });
                        },
                        value: 'private',
                        groupValue: roadWorthinessType,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: RadioListTile(
                        activeColor: Color(0xff003399),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text('Commercial',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sansation', fontStyle: FontStyle.normal),),
                        onChanged: (val){
                          setState(() {
                            roadWorthinessType = val;
                          });
                        },
                        value: 'commercial',
                        groupValue: roadWorthinessType,
                      ),
                    ),
                  ],
                ): Container(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomDropdown(
                    value: insuranceRenewal,
                    onChanged: (val){
                      setState(() {
                        insuranceRenewal = val;
                      });
                    },
                    items: insurancelist,
                    labelText: 'Insurance Renewal'
                ),
                insuranceRenewal == 'Yes' ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: RadioListTile(
                        activeColor: Color(0xff003399),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text('Private', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sansation', fontStyle: FontStyle.normal),),
                        onChanged: (val){
                          setState(() {
                            insuranceRenewalType = val;
                          });
                        },
                        value: 'private',
                        groupValue: insuranceRenewalType,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: RadioListTile(
                        activeColor: Color(0xff003399),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text('Commercial', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sansation', fontStyle: FontStyle.normal),),
                        onChanged: (val){
                          setState(() {
                            insuranceRenewalType = val;
                          });
                        },
                        value: 'commercial',
                        groupValue: insuranceRenewalType,
                      ),
                    ),
                  ],
                ): Container(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Builder(
                  builder: (context) => SizedBox(
                    width: MediaQuery.of(context).size.width*0.95,
                    height: MediaQuery.of(context).size.height*0.07,
                    child: CustomRaisedButton(
                      onPressed: () async {
                        if (!_formkey.currentState.validate()){
                          return;
                        }
                        if (roadWorthiness == null) {
                          Fluttertoast.showToast(
                              msg: 'Roadworthiness Field is Required',
                            textColor: Colors.black,
                            backgroundColor: Colors.white,
                            toastLength: Toast.LENGTH_LONG,
                          );
                          return;
                        }
                        if (insuranceRenewal== null) {
                          Fluttertoast.showToast(
                            msg: 'Insurance Renewal Field is Required',
                            textColor: Colors.black,
                            backgroundColor: Colors.white,
                            toastLength: Toast.LENGTH_LONG,
                          );
                          return;
                        }
                        _formkey.currentState.save();
                        int roadWPrice;
                        int insuranceRPrice;
//                        int licensePrice = await vehiclePaperBloc.getEngineCapacityprice(eCapicityvalue: engineCapacity);
                        if (roadWorthiness == 'Yes') {
                          roadWPrice = await vehiclePaperBloc.getRoadWorthinessPrice(roadWorthinessType: roadWorthinessType);
                        }
                        if (insuranceRenewal == 'Yes') {
                          insuranceRPrice = await vehiclePaperBloc.getInsuranceRenewalPrice(insuranceType: insuranceRenewalType);
                        }
                        print(roadWPrice.toString());
                        print(insuranceRPrice.toString());
//                        print(licensePrice.toString());
                        vehiclePaperBloc.setVehiclePaperDetails(vehiclePaperData:
                        VehiclePapersModel(
                          country: country,
                          state: state,
                          pin: pin,
                          registrationNumber: registrationNo,
                          engineNumber: engineNo,
                          vehicleMake: vehicleMake,
                          colour: colour,
                          engineCapacity: engineCapacity,
                          transactionDate: dformat.format(transDate),
                          expiryDate: dformat.format(expiryDate),
                          dateIssued: dformat.format(dateIssued),
                          roadWorthiness: roadWorthiness,
                          insuranceRenewal: insuranceRenewal,
                          roadWorthinessType: roadWorthinessType ?? '',
                          insuranceRenewalType: insuranceRenewalType ?? '',
                          requestTime: format.format(DateTime.now()),
                          requestDate: dformat.format(DateTime.now()),
                          vehicleId: registrationNo,
                          vehicleLicensePrice: 0, //licensePrice ,
                          insuranceRenewalPrice: insuranceRPrice ?? 0,
                          roadWorthinessPrice: roadWPrice ?? 0,
                        ),
                        );
                        widget.onPressed();
                      },
                      text: 'REQUEST VEHICLE PAPERS',
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
    );
  }
}
