import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/vehiclepapers.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/vehiclepapersbloc.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';
import 'package:vehispace/services/state_lga_service.dart';
import 'package:vehispace/widgets/datepicker.dart';
import '../../utils/constants.dart';
import '../../widgets/customdropdown.dart';
import '../../widgets/customtextformfield.dart';
import '../../widgets/customraisedbutton.dart';
import 'package:intl/intl.dart';


class VehiclePapersExisting extends StatefulWidget {
  int index;
  final Function onPressed;
  final Function onBack;
  VehiclePapersExisting({this.onPressed, this.index, this.onBack});
  @override
  _VehiclePapersExistingState createState() => _VehiclePapersExistingState();
}

class _VehiclePapersExistingState extends State<VehiclePapersExisting> {

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
  String model;
  String year;

  List <String> conditionlist = ['Damaged', 'Accident'];

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
//    VehiclePaperBloc().getPriceList();
  }

  @override
  Widget build(BuildContext context) {
    var vehiclePaperBloc = Provider.of<VehiclePaperBloc>(context);
    var vehiceBloc = Provider.of<MyVehicleBloc>(context);
//    var fetchStateLGA = Provider.of<FetchStateAndLGA>(context);
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
                Text(
                  vehiceBloc.vehiclesDetails[widget.index]['manufacturer'] + " " + vehiceBloc.vehiclesDetails[widget.index]['model'] + " " + vehiceBloc.vehiclesDetails[widget.index]['year'],
                  style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontSize: 18),
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
                    items: FetchStateAndLGA.states, //statelist,//countrylist,
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
                  intialValue: vehiclePaperBloc.vehiclePaperModel.colour ?? '',
                  hint: 'Vehicle Colour',
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
                MyDatePicker(
//              initialValue: vehiclePaperBloc.vehiclePaperModel.transactionDate ?? '',
                  customFormat: dformat,
                  hintText: 'Transaction Date',
                  labelText: 'Transaction Date',
                  onSaved: (val) {
                    setState(() {
                      transDate = val;
                    });
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
//                        String StransDate = dformat.format(transDate);
                        if (state == null) {
                          Fluttertoast.showToast(
                            msg: 'State field is empty',
                            textColor: Colors.black,
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Color(0xffe5e5e5),
                            fontSize: 16,
                          );
                          return;
                        }
                        if (!_formkey.currentState.validate()){
                          return;
                        }
//                        if (transDate == null){
//                          Fluttertoast.showToast(
//                            msg: 'transaction date field is empty',
//                            textColor: Colors.black,
//                            gravity: ToastGravity.CENTER,
//                            toastLength: Toast.LENGTH_SHORT,
//                            backgroundColor: Color(0xffe5e5e5),
//                            fontSize: 16,
//                          );
//                          return;
//                        }
//                        if (dateIssued == null) {
//                          Fluttertoast.showToast(
//                            msg: 'date issue field is empty',
//                            textColor: Colors.black,
//                            gravity: ToastGravity.CENTER,
//                            toastLength: Toast.LENGTH_SHORT,
//                            backgroundColor: Color(0xffe5e5e5),
//                            fontSize: 16,
//                          );
//                          return;
//                        }
//                        if (expiryDate.toString() == null) {
//                          Fluttertoast.showToast(
//                            msg: 'Expiry date field is empty',
//                            textColor: Colors.black,
//                            gravity: ToastGravity.CENTER,
//                            toastLength: Toast.LENGTH_SHORT,
//                            backgroundColor: Color(0xffe5e5e5),
//                            fontSize: 16,
//                          );
//                          return;
//                        }
                        if (roadWorthiness == null) {
                          Fluttertoast.showToast(
                            msg: 'road worthiness field is empty',
                            textColor: Colors.black,
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Color(0xffe5e5e5),
                            fontSize: 16,
                          );
                          return;
                        }
                        if (insuranceRenewal == null) {
                          Fluttertoast.showToast(
                            msg: 'insurance renewal field is empty',
                            textColor: Colors.black,
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Color(0xffe5e5e5),
                            fontSize: 16,
                          );
                          return;
                        }
                        _formkey.currentState.save();
                        int roadWPrice;
                        int insuranceRPrice;
                        int licensePrice = await vehiclePaperBloc.getEngineCapacityprice(eCapicityvalue: vehiceBloc.vehiclesDetails[widget.index]['engineCapacity']);
                        if (roadWorthiness == 'Yes') {
                          roadWPrice = await vehiclePaperBloc.getRoadWorthinessPrice(roadWorthinessType: roadWorthinessType);
                        }
                        if (insuranceRenewal == 'Yes') {
                          insuranceRPrice = await vehiclePaperBloc.getInsuranceRenewalPrice(insuranceType: insuranceRenewalType);
                        }
                        print(roadWPrice.toString());
                        print(insuranceRPrice.toString());
                        print(licensePrice.toString());
                        vehiclePaperBloc.setVehiclePaperDetails(vehiclePaperData:
                        VehiclePapersModel(
                          country: country ?? 'Nigeria',
                          state: state,
                          pin: pin,
                          registrationNumber: vehiceBloc.vehiclesDetails[widget.index]['registrationNumber'],
                          engineNumber: vehiceBloc.vehiclesDetails[widget.index]['engineNumber'],
                          vehicleMake: vehiceBloc.vehiclesDetails[widget.index]['manufacturer'],
                          model: vehiceBloc.vehiclesDetails[widget.index]['model'],
                          year: vehiceBloc.vehiclesDetails[widget.index]['year'],
                          colour: colour,
                          engineCapacity: vehiceBloc.vehiclesDetails[widget.index]['engineCapacity'],
//                          transactionDate: dformat.format(transDate),
//                          expiryDate: dformat.format(expiryDate),
//                          dateIssued: dformat.format(dateIssued),
                          roadWorthiness: roadWorthiness,
                          insuranceRenewal: insuranceRenewal,
                          roadWorthinessType: roadWorthinessType ?? '',
                          insuranceRenewalType: insuranceRenewalType ?? '',
                          requestTime: format.format(DateTime.now()),
                          requestDate: dformat.format(DateTime.now()),
                          vehicleId: registrationNo,
                          vehicleLicensePrice: licensePrice,
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
    );
  }
}
