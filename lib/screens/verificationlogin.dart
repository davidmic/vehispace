import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class MyVerificationLoginScreen extends StatefulWidget {
//  static String id = '/login';
  @override
  _MyVerificationLoginScreenState createState() => _MyVerificationLoginScreenState();
}

class _MyVerificationLoginScreenState extends State<MyVerificationLoginScreen> {
  var _formkey = GlobalKey<FormState>();
  String email;
  String pass;
  User user = User.create();
  MyValidator validator = MyValidator();
  bool _saving = false;
  
  @override

  Widget build(BuildContext context) {
    final FacebookAuth facebookAuth = Provider.of<FacebookAuth>(context);
    final EmailAndPasswordAuth emailAndPasswordAuth = Provider.of<EmailAndPasswordAuth>(context);
    final GoogleAuth googleAuth = Provider.of<GoogleAuth>(context);
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
                              );
                              setState(() {
                                _saving = false;
                              });
                              print ('My Status One' + emailAndPasswordAuth.status.toString());
                              if (emailAndPasswordAuth.status == EStatus.authenticated) {
                                Navigator.pushReplacementNamed(context, '/vehiclereg');
                                showDialog(
                                  context: context,
                                  builder: (context) {
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
                                      return InValidUser(
                                        message: EmailAndPasswordAuth.message,
                                      );
                                    }
                                );
                              }
                              else if (emailAndPasswordAuth.status == EStatus.emailresend) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
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

