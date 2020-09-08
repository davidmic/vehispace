import 'package:commons/commons.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/vehiclemodel.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/services/image_service.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/widgets/datepicker.dart';
import '../utils/constants.dart';
import '../widgets/customdropdown.dart';
import '../widgets/customtextformfield.dart';
import '../widgets/customraisedbutton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';


class MyVehicleRegistrationInApp extends StatefulWidget {
  @override
  _MyVehicleRegistrationInAppState createState() => _MyVehicleRegistrationInAppState();
}

class _MyVehicleRegistrationInAppState extends State<MyVehicleRegistrationInApp> {
  String vehicle;

  String manufacturer;

  String model;
  String year;

  List<String> vehiclelist = ['SUV', 'Sedan', 'Others'];

  List<String> manufacturerlist = ['Honda', 'Toyota', 'Kia'];

  List<String> engineCapacityList = ['1.0 - 2.0', '2.1 - 3.0', '3.1 Above'];

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _saving = false;
  bool isUploading = false;
  String engineNo; 
  String engineCapacity; 
  String vehicleRegNo; 
  String vehicleModel;
  String notlistedvehicleModel;
  String dateOfLastService;
  String milleage;
  String engineType;
   final format = DateFormat('dd-MM-yyyy');
     DateTime dateValue;




  // ImageService _imageService = ImageService();

  @override

  void initState () {
    super.initState();
    MyVehicleBloc().getVehicles();
  }
  @override

  Widget build(BuildContext context) {
    var _imageService = Provider.of<ImageService>(context);
    var _vehiclebloc = Provider.of<MyVehicleBloc>(context);
    var userProfile = Provider.of<UserProfile>(context);
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff003399),
          ),
          backgroundColor: Color(0xfff4f4f4),
          centerTitle: true,
          title: Text('Add Vehicle',
            style: Constants.appBarTitleColor,
          ),
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
              Text('Registering ...', style: TextStyle(fontFamily: 'Sansation'),),
            ]
          ),
        ),
        child: Form(
          key: _formkey,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(30),
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomDropdown(
                          value: vehicle,
                          onChanged: (val){
                            setState(() {
                              vehicle = val;
                            });
                          },
                          items: vehiclelist,
                          labelText: 'Vehicle Type'
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomDropdown(
                          value: manufacturer,
                          onChanged: (val) async {
                            await MyVehicleBloc().x(val);
                            setState(() {
                              manufacturer = val;
                              vehicleModel = null;
                              MyVehicleBloc.model;
                            });
                          },
                          items: MyVehicleBloc.vehicle,
                          labelText: 'Manufacturer'
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      // CustomDropdown(
                      //     value: model,
                      //     onChanged: (val){
                      //       model = val;
                      //     },
                      //     items: modellist,
                      //     labelText: 'Model'
                      // ),
                      CustomDropdown(
                          value: vehicleModel,
                          onChanged: (val){
                            setState(() {
                              vehicleModel = val;
                            });
                          },
                          items: MyVehicleBloc.model,
                          labelText: 'Vehicle Model'
                      ),
                      vehicleModel == 'Not Listed' ?  SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ): Container(),
                      vehicleModel == 'Not Listed' ?
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
                          notlistedvehicleModel = val;
                        },
                      ): Container(),
//                      CustomTextField(
//                        keyboardType: TextInputType.text,
//                        validator: (val){
//                          if (val.isEmpty){
//                            return 'Vehicle Model is required';
//                          }
//                          return null;
//                        },
////                        icon: Icon(Icons.security),
//                        hint: 'Model',
//                        onSaved: (val) {
//                          vehicleModel = val;
//                        },
//                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        validator: (val){
                          if (val.isEmpty){
                            return 'Year';
                          }
                          return null;
                        },
//                        icon: Icon(Icons.security),
                        hint: 'Year',
                        onSaved: (val) {
                          year = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if (val.isEmpty){
                            return 'Enter Vehicle Registration Number';
                          }
                          return null;
                        },
//                        icon: Icon(Icons.security),
                        hint: 'Vehicle Registration Number',
                        onSaved: (val) {
                          vehicleRegNo = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if (val.isEmpty){
                            return 'Enter Engine Type';
                          }
                          return null;
                        },
//                        icon: Icon(Icons.security),
                        hint: 'Engine Type',
                        onSaved: (val) {
                          engineType = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if (val.isEmpty){
                            return 'Enter Engine Number';
                          }
                          return null;
                        },
//                        icon: Icon(Icons.security),
                        hint: 'Engine Number',
                        onSaved: (val) {
                          engineNo = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomDropdown(
                          value: engineCapacity, //?? towingBloc.towingDetails.casaulty,
                          onChanged: (val){
                            print(val);
                            setState(() {
                              engineCapacity = val;
                            });
                          },
                          items: engineCapacityList,//countrylist,
                          labelText: 'Engine Capacity'
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      MyDatePicker(
                        customFormat: format,
                        labelText: 'Date of Last Service',
                        hintText: 'Date of Last Service',
                        initialValue: dateValue,
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2030),
                        onSaved: (val) {
                          dateValue = val;
                        },
                      ),
//                      DateTimeField(
//                        format: format,
//                        onShowPicker: (context, value) {
//                          return showDatePicker(
//                            context: context,
//                            initialDate: value ?? DateTime.now(),
//                            firstDate: DateTime(1990),
//                            lastDate: DateTime(2030)
//                            );
//                        },
//                        onSaved: (val) {
//                          dateValue = val;
//                        },
//                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        suffixIcon: Text('in miles'),
                        keyboardType: TextInputType.number,
                        validator: (val){
                          if (val.isEmpty){
                            return 'Enter Vehicle Mileage';
                          }
                          return null;
                        },
//                        icon: Icon(Icons.security),
                        hint: 'Mileage',
                        onSaved: (val) {
                          milleage = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text('Vehicle Photo', style: TextStyle(fontSize: 14, fontFamily: 'Sansation', fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: MediaQuery.of(context).size.width * 0.37,
                                decoration: BoxDecoration(
                                  color: Color(0xffe5e5e5),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                child:
                                ImageService.image != null ?
                                Stack(
                                    children: [
                                      Container(
                                          height: 200,
                                          width: 200,
                                          child: Image.asset(ImageService.image.path, fit: BoxFit.fill,)
                                      ),
                                      Positioned(
                                        top: 1,
                                        left: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                              icon: Icon(Icons.close, color: Colors.red, size: 30),
                                              onPressed: (){
                                                setState((){
                                                  ImageService.image = null;
                                                  ImageService.uploadFileURL = null;
                                                });
                                              }
                                          ),
                                        ),
                                      ),
                                    ]
                                ) :
                                IconButton(
                                  icon: Icon(Icons.add, size: 40, color: Color(0xff003399),),
                                  onPressed: () async {
                                    await _imageService.fromGallery();
                                    // setState(() {

                                    // });
                                  },
                                ),
                              ),
                              isUploading ? CircularProgressIndicator() : ImageService.uploadFileURL == null ? CustomRaisedButton(
                                onPressed: () async {
                                  setState(() {
                                    isUploading = true;
                                  });
                                  await _imageService.uploadFile(ImageService.image, 'users_vehicle/');
                                  setState(() {
                                    isUploading = false;
                                  });
                                },
                                text: 'Upload Photo',
                                borderColor: Color(0xffff0000),
                                color: Colors.white,
                                borderWidth: 1,
                                textColor: Color(0xffff0000),
                              ):
                              Padding(
                                padding: const EdgeInsets.only(right: 40.0),
                                child: Icon(Icons.check, size: 40, color: Colors.green,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Builder(
                        builder: (context) => SizedBox(
                          width: MediaQuery.of(context).size.width*0.95,
                          height: MediaQuery.of(context).size.height*0.07,
                          child: CustomRaisedButton(
                            onPressed: () async {
                              if (!_formkey.currentState.validate()) {
                                return;
                              }
                              if (vehicle == null) {
                                Fluttertoast.showToast(
                                  msg: 'Select Vehicle Type',
                                  textColor: Colors.white,
                                  gravity: ToastGravity.TOP,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black,
                                  fontSize: 16,
                                );
                                return;
                              }
                              if (manufacturer == null) {
                                Fluttertoast.showToast(
                                  msg: 'Select Vehicle Manufacturer',
                                  textColor: Colors.white,
                                  gravity: ToastGravity.TOP,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black,
                                  fontSize: 16,
                                );
                                return;
                              }
                              if (vehicleModel == null) {
                                Fluttertoast.showToast(
                                  msg: 'Vehicle Model is Required',
                                  textColor: Colors.white,
                                  gravity: ToastGravity.TOP,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black,
                                  fontSize: 16,
                                );
                                return;
                              }
                              if (ImageService.uploadFileURL == null) {
                                Fluttertoast.showToast(
                                  msg: 'Add Vehicle Photo',
                                  textColor: Colors.white,
                                  gravity: ToastGravity.BOTTOM,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black,
                                  fontSize: 16,
                                );
                                return;
                              }
                              _formkey.currentState.save();
                              setState(() {
                                _saving = true;
                              });
                              await  _vehiclebloc.addVehicle(
                                  vehicleModel: VehicleModel(
                                    vehicleType: vehicle,
                                    manufacturer: manufacturer,
                                    model: vehicleModel == 'Not Listed' ? notlistedvehicleModel : vehicleModel,
                                    regNo: vehicleRegNo,
                                    year: year,
                                    engineType: engineType,
                                    engineNo: engineNo,
                                    engineCapacity: engineCapacity,
                                    imageURL: ImageService.uploadFileURL,
                                    dateOfLastService: format.format(dateValue),
                                    millege: milleage,
                                    createdDate: format.format(DateTime.now()),
                                    userToken: userProfile.userToken,
                                  )
                              );
                              if (_vehiclebloc.status == Vehicle.successful){
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ValidUser();
                                    }
                                );
                              }
                              else if  (_vehiclebloc.status == Vehicle.failed){
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return InValidUser(
                                        message: MyVehicleBloc.message,
                                      );
                                    }
                                );
                              }
                            },
                            text: 'REGISTER',
                            elevation: 5.0,
                            color: Color(0xff003399),
                            textColor: Colors.white,
                          ),
                        ),
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
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              ),
            ),
          ),
        ),
      );
  }
}
