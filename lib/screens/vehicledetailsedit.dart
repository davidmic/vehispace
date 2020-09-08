import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:vehispace/widgets/customdropdown.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vehispace/models/vehiclemodel.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';

class MyVehicleDetailEdit extends StatefulWidget {
  String vehicle;
  String manufacturer;
  String model;
  String notlistedvehicleModel;
  String vehicleRegNo;
  String engineNumber;
  String engineCapacity;
  String vehicleId;

  MyVehicleDetailEdit ({
    this.vehicle,
    this.vehicleRegNo,
    this.manufacturer,
    this.model,
    this.engineNumber,
    this.engineCapacity,
    this.vehicleId,
  });

  @override
  _MyVehicleDetailEditState createState() => _MyVehicleDetailEditState();
}

class _MyVehicleDetailEditState extends State<MyVehicleDetailEdit> {

//  todo. Create a model for vehicle to aid collection of data to and from json
  List listOfCars;
  String vehicle;
  String manufacturer;
  String model;
  String notlistedmodel;
  String vehicleRegNo;
  String engineNumber;
  String engineCapacity;
  bool check = false;
  List<String> vehicleList = ['SUV','Sedan', 'Other'];
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
            // IconButton(
            //   icon: Icon(Icons.delete), color: Color(0xff003399),
            //   onPressed: (){
                
            //   },
            // ),
            // edit == false ?
            // IconButton(
            //   icon: Icon(Icons.edit), color: Color(0xff003399),
            //   onPressed: (){
            //     setState ((){
            //       edit = true;
            //     });
            //   },
            // )
            IconButton(
              icon: Icon(Icons.check), color: Color(0xff003399),
              onPressed: () async {
                if (!_formKey.currentState.validate()){
                  return;
                }
                _formKey.currentState.save();
                setState(() {
                });
//                if (vehicle == null) {
//                  Fluttertoast.showToast(
//                    msg: 'Choose Vehicle Make',
//                    textColor: Colors.white,
//                    gravity: ToastGravity.CENTER,
//                    toastLength: Toast.LENGTH_SHORT,
//                    backgroundColor: Colors.black,
//                    fontSize: 16,
//                  );
//                  return;
//                }
//                if (manufacturer == null) {
//                  Fluttertoast.showToast(
//                    msg: 'Add Vehicle Manufacturer',
//                    textColor: Colors.white,
//                    gravity: ToastGravity.CENTER,
//                    toastLength: Toast.LENGTH_SHORT,
//                    backgroundColor: Colors.black,
//                    fontSize: 16,
//                  );
//                  return;
//                }
//                if (model == null) {
//                  Fluttertoast.showToast(
//                    msg: 'Choose Vehicle Mode;',
//                    textColor: Colors.white,
//                    gravity: ToastGravity.CENTER,
//                    toastLength: Toast.LENGTH_SHORT,
//                    backgroundColor: Colors.black,
//                    fontSize: 16,
//                  );
//                  return;
//                }
                setState(() {
                  _saving = true;
                });
                  await vehiclebloc.upadteUserVehicleDetails(
                    vehicleModel: VehicleModel(
                      vehicleId: widget.vehicleId,
                      vehicleType: vehicle ?? widget.vehicle,
                      manufacturer: manufacturer ?? widget.manufacturer,
                      model: model == 'Not Listed' ? notlistedmodel : model ?? widget.model,
                      regNo: vehicleRegNo,
                      engineNo: engineNumber,
                      engineCapacity: engineCapacity,
                    )
                  ); 
                  setState(() {
                  _saving = false;
                });     
                if (vehiclebloc.status == Vehicle.successful){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 3));
                      return  ValidUser();
                    } 
                  );
                  setState(() {
                    edit = false;
                  });
                }
                else if (vehiclebloc.status == Vehicle.failed){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return  InValidUser(
                        message: MyVehicleBloc.message,
                      );
                    }    
                  );
                }
              },
            ),
          ],
        ),
        body: ModalProgressHUD(
              inAsyncCall: _saving,
              dismissible: false,
              progressIndicator: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10,),
                      Text('Processing .....', style: TextStyle(fontFamily: 'Sansation'),),
                    ]
                ),
              ),
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15,10,15,10),
                    child: Column(
                      children: <Widget>[
                        CustomDropdown(
                            value: vehicle,
                            hintText: widget.vehicle,
                            onChanged: (val){
                              setState(() {
                                vehicle = val;
                              });
                            },
                            items: vehicleList,
                            labelText: 'Vehicle',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomDropdown(
                            value: manufacturer,
                            hintText: widget.manufacturer,
                            onChanged: (val) async {
                              await MyVehicleBloc().x(val);
                              setState(() {
                                manufacturer = val;
                                model = null;
                                check = true;
                                MyVehicleBloc.model;
                              });
                            },
                            items: MyVehicleBloc.vehicle,
                            labelText: 'Manufacturer'
                        ),
//                        CustomTextField(
//                          readOnly: false,
//                          intialValue: widget.manufacturer,
//                          hint: 'Manufacturer',
//                          labelText: 'Manufacturer',
//                          onSaved: (val) {
//                          manufacturer = val;
//                          },
//                          keyboardType: TextInputType.text,
//                          validator: (val) {
//                            if(val.isEmpty){
//                              return 'Manufacturer is Required';
//                            }
//                            return null;
//                          },
//                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomDropdown(
                            value: model,
                            hintText: check ? '' : widget.model,
                            onChanged: (val){
                              setState(() {
                                model = val;
                              });
                            },
                            items: MyVehicleBloc.model,
                            labelText: 'Vehicle Model'
                        ),
                        model == 'Not Listed' ?  SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ): Container(),
                        model == 'Not Listed' ?
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          validator: (val){
                            if (val.isEmpty){
                              return 'Vehicle Model is required';
                            }
                            return null;
                          },
//                        icon: Icon(Icons.security),
                          hint: 'Model',
                          onSaved: (val) {
                            notlistedmodel = val;
                          },
                        ): Container(),
//                         CustomTextField(
//                          readOnly: false,
//                          intialValue: widget.model,
//                          hint: 'Model',
//                          labelText: 'Model',
//                          onSaved: (val) {
//                           model =  val;
//                          },
//                          keyboardType: TextInputType.text,
//                          validator: (val) {
//                            if(val.isEmpty){
//                              return 'Model is Required';
//                            }
//                            return null;
//                          },
//                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomTextField(
                          readOnly: false,
                          intialValue: widget.vehicleRegNo,
                          hint: 'Vehicle Registration Number',
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
                          intialValue: widget.engineNumber,
                          hint: 'Engine Number',
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
                          intialValue: widget.engineCapacity,
                          hint: 'Engine Capacity',
                          labelText: 'Engine Capacity',
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          onSaved: (val) {
                          engineCapacity = val;
                          },
                          keyboardType: TextInputType.number,
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
      ),
    );
  }
}
