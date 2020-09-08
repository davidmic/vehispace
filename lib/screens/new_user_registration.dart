import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vehispace/services/state_lga_service.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/userauth/googleAuth.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/customdropdown.dart';
import '../models/user.dart';
import '../widgets/customraisedbutton.dart';
import '../widgets/customtextformfield.dart';
import '../utils/validator.dart';
import 'package:provider/provider.dart';
import '../userauth/facebookauth.dart';
import '../userauth/EmailAndPasswordAuth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
  import 'package:firebase_messaging/firebase_messaging.dart';

class MyNewUserRegistration extends StatefulWidget {
  @override
  _MyNewUserRegistrationState createState() => _MyNewUserRegistrationState();
}

class _MyNewUserRegistrationState extends State<MyNewUserRegistration> {
//  List<String> country = ['Nigeria', 'Ghana', 'Niger'];
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  NewUser newUser = NewUser();
  String email;
  MyValidator validator = MyValidator();
  String userToken;
  String password;
  String phoneNumber;
  String firstName;
  String lastName;
  String referralCode;
  String countryValue = 'Nigeria';
  String stateValue;
  String lgaValue;
  final format = DateFormat('dd-MM-yyyy');

  List<String> country = ['Nigeria'];
  List<String> state = ['Lagos'];
  List<String> region = ['Eti Osa', 'Surulere', 'Ikorodu'];
   bool _saving = false;
   var now = DateTime.now();
//  String dvalue;

//  getLGA (String state) {
//    FetchStateAndLGA().getLGA(state);
//  }
  getToken () async {
    await _firebaseMessaging.getToken().then((deviceToken){
      userToken = deviceToken.toString();
      print(deviceToken.toString());
      return userToken;
    });
  }
  @override

  void initState () {
    super.initState();
    FetchStateAndLGA().getStates();
    getToken();
  }
  @override

  Widget build(BuildContext context) {
    FacebookAuth facebookAuth = Provider.of<FacebookAuth>(context);
     GoogleAuth googleAuth = Provider.of<GoogleAuth>(context);
      EmailAndPasswordAuth emailAndPasswordAuth = Provider.of<EmailAndPasswordAuth>(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        dismissible: false,
        progressIndicator: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10,),
                Text('Creating User Profile ...', style: TextStyle(fontFamily: 'Sansation'),),
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
                      GestureDetector(
                        child: Icon(Icons.close,
                          size: 40,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Create Account',
                            style: Constants.titleText,
                          ),
                          Text(
                            'Create a free account and get access to solutions for maintaining your vehicle',
                            style: Constants.subtitleText,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomTextField(
                        hint: 'First Name',
                        onSaved: (val) {
                          firstName = val;
                        },
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if(val.isEmpty){
                            return 'First Name is Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        hint: 'Last Name',
                        onSaved: (val) {
                          lastName = val;
                        },
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if(val.isEmpty){
                            return 'Last Name is Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        validator: validator.emailValidator,
//                        icon: Icon(Icons.mail),
                        hint: 'Your Email Address',
                        onSaved: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        hint: 'Phone Number',
                        onSaved: (val) {
                          phoneNumber = val;
                        },
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if(val.isEmpty){
                            return 'Enter Phone Number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        hint: 'Password',
                        onSaved: (val) {
                          password = val;
                        },
                        obsecure: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) {
                          if(val.isEmpty || val.length < 6){
                            return 'Password is Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomDropdown(
                        isDense: true,
                        labelText: 'Country',
                        value: countryValue,
                        onChanged: (val) {
                          setState(() {
                            countryValue = val;
                            print(val);
                          });
                        },
                        items: country,
//                      icon: Icon(Icons.flag),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomDropdown(
                        isDense: true,
                        labelText: 'State',
                        value: stateValue,
                        onChanged: (val) {
                          setState(() {
//                            getLGA(val);
                            stateValue = val;
                            print(val);
                          });
                        },
                        items: FetchStateAndLGA.states,
//                      icon: Icon(Icons.flag),
                      ),
//                      SizedBox(
//                        height: MediaQuery.of(context).size.height * 0.02,
//                      ),
//                      CustomDropdown(
//                        isDense: true,
//                        labelText: 'L.G.A',
//                        value: lgaValue,
//                        onChanged: (val) {
//                          setState(() {
//                            lgaValue = val;
//                            print(val);
//                          });
//                        },
//                        items: FetchStateAndLGA.nigerianLGA,
////                      icon: Icon(Icons.flag),
//                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextField(
                        hint: 'Referral Phone or Code',
                        onSaved: (val) {},
                        keyboardType: TextInputType.text,
//              icon: Icon(Icons.mail),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.95,
                        height: MediaQuery.of(context).size.height*0.07,
                        child: Builder(
                          builder: (context) =>
                           CustomRaisedButton(
//                        onPressed: (){
//                          Navigator.popAndPushNamed(context, '/vehiclereg');
//
//                        },
                              onPressed: () async {
                                if(!_formkey.currentState.validate()){
                                  return;
                                }
                                if (countryValue == null) {
                                  Fluttertoast.showToast(
                                    msg: 'Enter Country',
                                    textColor: Colors.black,
                                    gravity: ToastGravity.CENTER,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Color(0xffe5e5e5),
                                    fontSize: 16,
                                    );
                                  return;
                                }
                                 if (stateValue == null) {
                                    Fluttertoast.showToast(
                                    msg: 'Enter State',
                                    textColor: Colors.black,
                                    gravity: ToastGravity.CENTER,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Color(0xffe5e5e5),
                                    fontSize: 16,
                                    );
                                  //  Scaffold.of(context).showSnackBar(
                                  // SnackBar(content: Text('Enter State')),
                                  //  );
                                  return;
                                }
                                //  if (lgaValue == null) {
                                //     Fluttertoast.showToast(
                                //     msg: 'Enter State LGA',
                                //     textColor: Colors.white,
                                //     gravity: ToastGravity.CENTER,
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     backgroundColor: Color(0xffe5e5e5),
                                //     fontSize: 16,
                                //     );
                                //   // Scaffold.of(context).showSnackBar(
                                //   // SnackBar(content: Text('Enter LGA')),
                                //   //  );
                                //   return;
                                // }
                                _formkey.currentState.save();
                                print('reg button pressed');
                                setState(() {
                                  _saving = true;
                                });
                                 await emailAndPasswordAuth.storeUser(
                                    newuser: NewUser(
                                      firstName: firstName,
                                      lastName: lastName,
                                      passoword: password,
                                      referralCode: referralCode,
                                      email: email,
                                      phoneNumber: phoneNumber,
                                      country: countryValue,
                                      state: stateValue,
                                      // lga: lgaValue,
                                      userToken: userToken,
                                      createdDate: format.format(now),
                                    ),
                                  );
                                setState(() {
                                  _saving = false;
                                });
                                if (emailAndPasswordAuth.status == EStatus.authenticated){
                                  Navigator.pushReplacementNamed(context, '/verificationmail');
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                        return ValidUser();
                                      }
                                  );
                                }
                                else if (emailAndPasswordAuth.status == EStatus.unauthenticated){
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                        return InValidUser(
                                          message: EmailAndPasswordAuth.message,
                                        );
                                      }
                                  );
                                }
                              },
                            text: 'CREATE ACCOUNT',
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
                           GestureDetector(
                             onTap: () async {
                               print('Login with facebook');
                               setState(() {
                                 _saving = true;
                               });
                               await facebookAuth.login(
                                 userToken: userToken,
                               );
                               setState(() {
                                 _saving = false;
                               });
                               if (facebookAuth.status == FBStatus.authenticated){
                                 Navigator.popAndPushNamed(context, '/vehiclereg');
                                 showDialog(
                                     context: context,
                                     builder: (context) {
                                       Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                       return ValidUser();
                                     }
                                 );
                               }
                               else if (facebookAuth.status == FBStatus.unauthenticated){
                                 showDialog(
                                     context: context,
                                     builder: (context) {
                                       Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                       return InValidUser();
                                     }
                                 );
                               }
                             },
                             child: Image.asset(
                               'assets/logo/fb.png',
                               height: 50,
                               width: 30,
                             ),
                           ),
                           SizedBox(
                             width: 20,
                           ),
                           GestureDetector(
                             onTap: () async {
                               print('Login with google');
                               setState(() {
                                 _saving = true;
                               });
                                await googleAuth.handleSignIn(
                                  userToken: userToken,
                                );
                                setState(() {
                                  _saving = false;
                                });
                               if (googleAuth.status == GStatus.authenticated){
                                 Navigator.popAndPushNamed(context, '/vehiclereg');
                                 showDialog(
                                     context: context,
                                     builder: (context) {
                                       Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                       return ValidUser();
                                     }
                                 );
                               }
                               else if (googleAuth.status == GStatus.unauthenticated){
                                 showDialog(
                                     context: context,
                                     builder: (context) {
                                       Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                       return InValidUser();
                                     }
                                 );
                               }
                             },
                             child: Image.asset(
                               'assets/logo/google.png',
                               height: 50,
                               width: 30,
                             ),
                           ),
                         ],
                       ),
                       SizedBox(
                         height: MediaQuery.of(context).size.height * 0.01,
                       ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Already have an account? Log in',
                              style: Constants.redText,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
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
