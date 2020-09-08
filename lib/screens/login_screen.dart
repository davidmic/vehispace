import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/userauth/authchecker.dart';
import '../widgets/customtextformfield.dart';
import '../widgets/customraisedbutton.dart';
import '../models/user.dart';
import '../utils/validator.dart';
import 'package:provider/provider.dart';
import '../userauth/facebookauth.dart';
import '../userauth/EmailAndPasswordAuth.dart';
import '../userauth/googleAuth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyLoginScreen extends StatefulWidget {
//  static String id = '/login';
  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String userToken;
  var _formkey = GlobalKey<FormState>();
  String email;
  String pass;
  User user = User.create();
  MyValidator validator = MyValidator();
  bool _saving = false;

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
    getToken();
  }
  @override

  Widget build(BuildContext context) {
    final FacebookAuth facebookAuth = Provider.of<FacebookAuth>(context);
    final EmailAndPasswordAuth emailAndPasswordAuth = Provider.of<EmailAndPasswordAuth>(context);
    final GoogleAuth googleAuth = Provider.of<GoogleAuth>(context);
    final UserProfile userProfile = Provider.of<UserProfile>(context);
    userProfile.userToken = userToken;
    print(userProfile.userToken);
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
              Text('Authenticating ...', style: TextStyle(fontFamily: 'Sansation'),),
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
                          Navigator.pushReplacementNamed(context, '/usermgt');
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
                            'Login',
                            style: TextStyle(
                              color: Color(0xff003399),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sansation',
                              fontSize: 34,
                            ),
                          ),
                          Text(
                            'Securely login to your vehispace',
                            style: TextStyle(
                              color: Colors.black54,
//                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sansation',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
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
                        obsecure: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: validator.password,
//                        icon: Icon(Icons.security),
                        labelText: 'Your Password',
                        hint: '*******',
                        onSaved: (val) {
                          pass = val;
                        },
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
                              _formkey.currentState.save();
                              setState(() {
                                _saving = true;
                              });
                              user.email = email;
                              user.password = pass;
                              print(user.email);
                              print(user.password);
                              await emailAndPasswordAuth.signInUser(
                                email: email,
                                password: pass,
                                userToken: userToken,
                              );
                              setState(() {
                                _saving = false;
                              });
                              print ('My Status One' + emailAndPasswordAuth.status.toString());
                              if (emailAndPasswordAuth.status == EStatus.authenticated) {
//                                Navigator.pushReplacementNamed(context, '/offerservices');
                                Navigator.of(context).pushNamedAndRemoveUntil('/offerservices', (Route<dynamic> route) => false);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                    return ValidUser();
                                  }
                                );
                                print ('My Status Two' + emailAndPasswordAuth.status.toString());
                                return;
                              }
                              else if (emailAndPasswordAuth.status == EStatus.unauthenticated) {
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
                              else if (emailAndPasswordAuth.status == EStatus.emailresend) {
                                Navigator.pushReplacementNamed(context, '/verificationmail');
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                      return UserNotVerified();
                                    }
                                );
                              }
                            },
                            text: 'LOG IN',
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
                          GestureDetector(
                            onTap: () async {
                              print('Login with facebook');
                               setState(() {
                                _saving = true;
                              });
                             await facebookAuth.fblogin(userToken);
                              setState(() {
                                _saving = false;
                              });
                              // print ('about to run checker');
                              if (facebookAuth.status == FBStatus.authenticated){
                                await facebookAuth.fblogOut();
//                                Navigator.pushReplacementNamed(context, '/offerservices');
                                Navigator.of(context).pushNamedAndRemoveUntil('/offerservices', (Route<dynamic> route) => false);
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
                                      return InValidUser(
                                        message: FacebookAuth.message,
                                      );
                                    }
                                );
                              }
                              // print ('done with checker');
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
                              await googleAuth.signIn(userToken);
                              setState(() {
                                _saving = false;
                              });
                              print ('about to run checker');
                              if (googleAuth.status == GStatus.authenticated) {
                                await googleAuth.handleSignOut();
//                                Navigator.pushReplacementNamed(context, '/offerservices');
                                Navigator.of(context).pushNamedAndRemoveUntil('/offerservices', (Route<dynamic> route) => false);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                      return ValidUser();
                                    }
                                );
                                print ('My Status One' + googleAuth.status.toString());
                                return;
                              }
                              else if (googleAuth.status == GStatus.unauthenticated) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                      return InValidUser(
                                        message: GoogleAuth.message,
                                      );
                                    }
                                );
                              }
                              print ('done with checker');
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
                              'Don\'t have an account? Register',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Sansation',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffff0000)),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'Sansation', fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgotpassword');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
//                  FlatButton(child: Text('FB Out'), onPressed: (){facebookAuth.fblogOut();},),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  } 
}

