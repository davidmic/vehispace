import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/user.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/customdropdown.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:vehispace/provider/userprofilebloc.dart';

class MyProfileEdit extends StatefulWidget {
  @override
  _MyProfileEditState createState() => _MyProfileEditState();
}

class _MyProfileEditState extends State<MyProfileEdit> {
  var _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String number;
  String driverLicense;
  String driverLicenseExpiry;
  String gender;
  List<String> genderList = ['Male', 'Female'];
  Firestore _store = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    var userprofile = Provider.of<UserProfile>(context);
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff003399),
        ),
        backgroundColor: Color(0xfff4f4f4),
        centerTitle: true,
        title: Text(
          'My Profile',
          style: Constants.appBarTitleColor,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: _store.collection('usermanagement').document(userprofile.userid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              print(snapshot.data.toString());
              DocumentSnapshot user = snapshot.data;
              return ModalProgressHUD(
                inAsyncCall: _saving,
                dismissible: false,
                progressIndicator: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text('Processing ...', style: TextStyle(fontFamily: 'Sansation'),),
                      ]
                  ),
                ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(15,10,15,10),
                      color: Color(0xffe5e5e5),
                      child: Column(
                          children: <Widget>[
                        CustomTextField(
                          intialValue: user['firstname'],
                          readOnly: false,
                          hint: 'First Name',
                          onSaved: (val) {
                            firstName = val;
                          },
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'First Name is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomTextField(
                          intialValue: user['lastname'],
                          readOnly: false,
                          hint: 'Last Name',
                          onSaved: (val) {
                           lastName = val;
                          },
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Last Name is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomTextField(
                          intialValue: user['phone'] ?? "",
                          readOnly: false,
                          hint: 'Mobile Number',
                          onSaved: (val) {
                           number = val;
                          },
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Mobile Number is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomDropdown(
                          // intialValue: user['firstname'],
                          // readOnly: true,
                            value: gender ?? user['gender'],
                            onChanged: (val) {
                              setState(() {
                                gender = val;
                              });
                            },
                            items: genderList,
                            labelText: 'Gender'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomTextField(
                          intialValue: user['driverlicense'],
                          readOnly: false,
                          hint: 'Driver License (Optional)',
                          onSaved: (val) {
                            driverLicense = val;
                          },
                          keyboardType: TextInputType.text,

                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomTextField(
                           intialValue: user['driverlicenseexpiry'],
                          readOnly: false,
                          hint: 'Driver License Expiry',
                          onSaved: (val) {
                          driverLicenseExpiry = val;
                          },
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Field is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Builder(
                          builder: (context) => SizedBox(
                            width: MediaQuery.of(context).size.width*0.95,
                            height: MediaQuery.of(context).size.height*0.07,
                            child: CustomRaisedButton(
                              onPressed: () async {
                                if (!_formKey.currentState.validate()){
                                  return;
                                }

//                                setState(() {
//                                  _saving = true;
//                                });
                                if (gender == null) {
                                  Fluttertoast.showToast(
                                    msg: 'Choose Gender',
                                    textColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.black,
                                    fontSize: 16,
                                  );
                                  return;

                                }
                                _formKey.currentState.save();

                                setState(() {
                                  _saving = true;
                                });
                                  await userprofile.upadteUserDetails(
                                    user: NewUser(
                                      firstName: firstName,
                                      lastName: lastName,
                                      phoneNumber: number,
                                      gender: gender,
                                      driverLicense: driverLicense,
                                      driverLicenseExpiry: driverLicenseExpiry,
                                    )
                                  ); 
                                  setState(() {
                                  _saving = false;
                                });     
                                if (userprofile.status == Update.success){
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return  ValidUser();
                                    }
                                  );
                                }
                                else if (userprofile.status == Update.failed){
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return  InValidUser(
                                        message: UserProfile.message,
                                      );
                                    }    
                                  );
                                }
                              },
                              text: 'SAVE',
                              elevation: 5.0,
                              color: Color(0xff003399),
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
            ],
          ),
        ),
              );
     }
          }
        ),

    );
  }
}
