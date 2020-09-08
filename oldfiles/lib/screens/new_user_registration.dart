import 'package:flutter/material.dart';
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
import 'package:commons/commons.dart';

class MyNewUserRegistration extends StatefulWidget {
  @override
  _MyNewUserRegistrationState createState() => _MyNewUserRegistrationState();
}

class _MyNewUserRegistrationState extends State<MyNewUserRegistration> {
//  List<String> country = ['Nigeria', 'Ghana', 'Niger'];
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//  NewUser newUser = NewUser();
  String email;
  MyValidator validator = MyValidator();
  String password;
  String phoneNumber;
  String firstName;
  String lastName;
  String referralCode;
  String countryvalue;
  String statevalue;
  String regionvalue;

  List<String> country = ['Nigeria'];
  List<String> state = ['Lagos'];
  List<String> region = ['Eti Osa', 'Surulere', 'Ikorodu'];

//  String dvalue;

  @override
  Widget build(BuildContext context) {
    // FacebookAuth facebookAuth = Provider.of<FacebookAuth>(context);
    // GoogleAuth googleAuth = Provider.of<GoogleAuth>(context);
    EmailAndPasswordAuth emailAndPasswordAuth = Provider.of<EmailAndPasswordAuth>(context);
     showLoading () {
       if (emailAndPasswordAuth.status == Status.authenticating) {
         return
           push(
             context,
             loadingScreen(
               context,
               duration: Duration(
                 seconds: 10,
               ),
               loadingType: LoadingType.JUMPING,
             ),
           );

//           showDialog(
//             barrierDismissible: false,
//             context: context,
//             builder: (context) {
//               return AlertDialog(
////                 title: Text('User Authentication Failed, Try Again'),
//                 content:  Center(child: CircularProgressIndicator(),),
//                 actions: <Widget>[
//                   FlatButton(
//                     child: Text('Ok'),
//                     onPressed: (){
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               );
//             }
//         );
       }
       else if (emailAndPasswordAuth.status == Status.authenticated) {
         return
           successDialog(context,
             "Profile Successfully Created",
           closeOnBackPress: false,
//           positiveText: 'Okay',
           neutralAction: (){
             Navigator.pushReplacementNamed(context, '/vehiclereg');
           }
         );
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
////                 title: Text('User Authentication Failed, Try Again'),
//                 content:  Center(child: CircularProgressIndicator(),),
//                 actions: <Widget>[
//                   FlatButton(
//                     child: Text('Ok'),
//                     onPressed: (){
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               );
//             }
//         );
//         return Navigator.pushReplacementNamed(context, '/offerservices');
       }
       else if (emailAndPasswordAuth.status == Status.unauthenticated) {

         return
           errorDialog(context,
             "Profile Email Already Exists",
           neutralText: 'Ok',
           negativeAction: (){
              Navigator.pop(context);
           }
         );
//           showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('User Authentication Failed, Try Again'),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Ok'),
//                   onPressed: (){
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             );
//           }
//         );
       }
     }
    return Scaffold(
      body: Form(
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
//                    CustomTextField(
//                      hint: 'Middle Name | Optional',
//                      onSaved: (val) {},
//                      keyboardType: TextInputType.text,
//                      validator: (val) {},
//                    ),
//
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
//              icon: Icon(Icons.mail),
                    ),
//                    SizedBox(
//                      height: MediaQuery.of(context).size.height * 0.02,
//                    ),
//                    CustomTextField(
//                      hint: 'Confirm Password',
//                      onSaved: (val) {},
//                      keyboardType: TextInputType.visiblePassword,
//                      validator: (val) {
//                        if(val != password){
//                          return 'Password Does Not Match';
//                        }
//                        return null;
//                      },
////              icon: Icon(Icons.mail),
//                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomDropdown(
                      isDense: true,
                      labelText: 'Country',
                      value: countryvalue,
                      onChanged: (val) {
                        setState(() {
                          countryvalue = val;
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
                      value: statevalue,
                      onChanged: (val) {
                        setState(() {
                          statevalue = val;
                          print(val);
                        });
                      },
                      items: state,
//                      icon: Icon(Icons.flag),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomDropdown(
                      isDense: true,
                      labelText: 'Region',
                      value: regionvalue,
                      onChanged: (val) {
                        setState(() {
                          regionvalue = val;
                          print(val);
                        });
                      },
                      items: region,
//                      icon: Icon(Icons.flag),
                    ),
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
                      child: CustomRaisedButton(
                        onPressed: (){
                          Navigator.popAndPushNamed(context, '/vehiclereg');
                        },
//                          onPressed: () async {
//                            if(!_formkey.currentState.validate()){
//                              return;
//                            }
//                            _formkey.currentState.save();
//                            print('reg button pressef');
//                            showLoading();
//                             await emailAndPasswordAuth.storeUser(
//                                newuser: NewUser(
//                                  firstName: firstName,
//                                  lastName: lastName,
//                                  passowrd: password,
//                                  referralCode: referralCode,
//                                  email: email,
//                                  phoneNumber: phoneNumber,
//                                ),
//                              );
//
//                            showLoading();
//
//
////                            setState(() {
////                              showLoading();
////                            });
//                          },
                          text: 'CREATE ACCOUNT',
                          color: Color(0xff003399),
                          textColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // facebookAuth.login();
                            print('Login with facebook');
                            // facebookAuth.login();
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
                          onTap: () {
                            print('Login with google');
                            // googleAuth.handleSignIn();
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
    );
  }
}
