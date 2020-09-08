import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vehispace/screens/vehicledetailsedit.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:vehispace/widgets/customdropdown.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vehispace/models/vehiclemodel.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';

class MyVehicleDetail extends StatefulWidget {
  List listOfCars;
  String vehicle;
  String manufacturer;
  String model;
  String vehicleRegNo;
  String engineNumber;
  String engineCapacity;
  String vehicleId;

  MyVehicleDetail ({
    this.vehicle,
    this.vehicleRegNo,
    this.manufacturer,
    this.model,
    this.engineNumber,
    this.engineCapacity,
    this.vehicleId,
  });

  @override
  _MyVehicleDetailState createState() => _MyVehicleDetailState();
}

class _MyVehicleDetailState extends State<MyVehicleDetail> {

//  todo. Create a model for vehicle to aid collection of data to and from json
  List listOfCars;
  String vehicle;
  String manufacturer;
  String model;
  String vehicleRegNo;
  String engineNumber;
  String engineCapacity;
  List<String> vehicleList = [];
  bool edit = false;
  var _formKey = GlobalKey<FormState>();
  bool _saving = false;
 Firestore _store = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    var vehiclebloc = Provider.of<MyVehicleBloc>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Color(0xffe5e5e5),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff003399),
          ),
          backgroundColor: Color(0xfff4f4f4),
          centerTitle: true,
          title: Text('Vehicles',
            style: Constants.appBarTitleColor,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete), color: Color(0xff003399),
              onPressed: (){
                
              },
            ),
            IconButton(
              icon: Icon(Icons.edit), color: Color(0xff003399),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyVehicleDetailEdit(
                  vehicle: widget.vehicle,
                  manufacturer: widget.manufacturer,
                  model: widget.model,
                  vehicleRegNo: widget.vehicleRegNo,
                  engineNumber: widget.engineNumber,
                  engineCapacity: widget.engineCapacity,
                  vehicleId: widget.vehicleId,
                )));
              },
            ),
            // IconButton(
            //   icon: Icon(Icons.check), color: Color(0xff003399),
            //   onPressed: () async {
            //     if (!_formKey.currentState.validate()){
            //       return;
            //     }
            //     _formKey.currentState.save();
            //     setState(() {
            //     });
            //     if (vehicle == null) {
            //       Fluttertoast.showToast(
            //         msg: 'Choose Gender',
            //         textColor: Colors.white,
            //         gravity: ToastGravity.CENTER,
            //         toastLength: Toast.LENGTH_SHORT,
            //         backgroundColor: Colors.black,
            //         fontSize: 16,
            //       );
            //       return;
            //     }
            //     setState(() {
            //       _saving = true;
            //     });
            //       await vehiclebloc.upadteUserVehicleDetails(
            //         vehicleModel: VehicleModel(
            //           vehicleId: widget.vehicleId,
            //           vehicle: vehicle,
            //           manufacturer: manufacturer,
            //           model: model,
            //           regNo: vehicleRegNo,
            //           engineNo: engineNumber,
            //           engineCapacity: engineCapacity,
            //         )
            //       ); 
            //       setState(() {
            //       _saving = false;
            //     });     
            //     if (vehiclebloc.status == Vehicle.successful){
            //       showDialog(
            //         context: context,
            //         builder: (context) {
            //           return  ValidUser();
            //         } 
            //       );
            //       setState(() {
            //         edit = false;
            //       });
            //     }
            //     else if (vehiclebloc.status == Vehicle.failed){
            //       showDialog(
            //         context: context,
            //         builder: (context) {
            //           return  InValidUser(
            //             message: MyVehicleBloc.message,
            //           );
            //         }    
            //       );
            //     }
            //   },
            // ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(15,10,15,10),
              child: Column(
                children: <Widget>[
                  CustomDropdown(
                      value: vehicle ?? widget.vehicle,
                      onChanged:  null,
                      items: vehicleList,
                      labelText: 'Vehicle',
                      hintText: widget.vehicle,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomTextField(
                    readOnly: true,
                    // intialValue: edit == false ? '' : widget.manufacturer,
                    hint: widget.manufacturer,
                    labelText: 'Manufacturer',
                    onSaved: (val) {
                    manufacturer = val;
                    },
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if(val.isEmpty){
                        return 'Manufacturer is Required';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  
                  CustomTextField(
                    readOnly: true,
                    // intialValue: edit == true ? widget.model : '',
                    hint: widget.model,
                    labelText: 'Model',
                    onSaved: (val) {
                     model =  val;
                    },
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if(val.isEmpty){
                        return 'Model is Required';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomTextField(
                    readOnly: true,
                    // intialValue: edit == false ? '' : widget.vehicleRegNo,
                    hint: widget.vehicleRegNo,
                    labelText: 'Vehcle Registration Number',
                    onSaved: (val) {
                      vehicleRegNo = val;
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
                    // intialValue: edit == false ? '' : widget.engineNumber,
                    hint: widget.engineNumber,
                    labelText: 'Engine Number',
                    onSaved: (val) {
                      engineNumber = val;
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
                    // intialValue: edit == false ? '' : widget.engineCapacity,
                    hint: widget.engineCapacity,
                    labelText: 'Engine Capacity',
                    onSaved: (val) {
                    engineCapacity = val;
                    },
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if(val.isEmpty){
                        return 'Engine Capacity is Required';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
