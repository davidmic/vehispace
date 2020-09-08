import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/customraisedbutton.dart';
import '../widgets/customtextformfield.dart';
import '../utils/validator.dart';
import '../utils/constants.dart';
import 'package:vehispace/models/user.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/userauth/EmailAndPasswordAuth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyForgotPassword extends StatefulWidget {
  @override
  _MyForgotPasswordState createState() => _MyForgotPasswordState();
}

class _MyForgotPasswordState extends State<MyForgotPassword> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  MyValidator validator = MyValidator();

  User user = User.create();

  bool _saving = false;

  String email;

  @override 
  Widget build(BuildContext context) {
    var _emailAndPasswordAuth = Provider.of<EmailAndPasswordAuth>(context);
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
                Text('Processing ...', style: TextStyle(fontFamily: 'Sansation'),),
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Forgot Password',
                            style: Constants.titleText,
                          ),
                          Text(
                            'Enter your email to reset your passwords',
                            style: Constants.subtitleText,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        validator: validator.emailValidator,
//                        icon: Icon(Icons.mail),
                        labelText: 'Your Email Address',
                        hint: 'e.g: johndoe@mail.com',
                        onSaved: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
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
                              user.email = email;
                              setState ((){
                                _saving = true;
                              });
                              await _emailAndPasswordAuth.resetPassword(user.email);
                              setState ((){
                                _saving = false;
                              });
                              Fluttertoast.showToast(
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG,
                                msg: EmailAndPasswordAuth.message,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                            },
                            text: 'RESET PASSWORD',
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
