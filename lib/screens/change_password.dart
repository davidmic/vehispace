import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/userauth/EmailAndPasswordAuth.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/utils/validator.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'dart:io';

class ChangePassword extends StatefulWidget {

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nP;
  TextEditingController rP;

  MyValidator validator = MyValidator();

  void initState () {
    super.initState();
    nP = TextEditingController();
    rP = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var emailAndPassWordAuth = Provider.of<EmailAndPasswordAuth>(context);
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff003399),
        ),
        backgroundColor: Color(0xfff4f4f4),
        centerTitle: true,
        title: Text('Change Password', style: Constants.appBarTitleColor,),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15,10,15,10),
                child: Column(
                  children: <Widget>[
//                    CustomTextField(
//                      keyboardType: TextInputType.text,
//                      validator: (val) {
//                        if (val.isEmpty) {
//                          return 'Enter Old Current Password';
//                        }
//                        return null;
//                      },
////                        icon: Icon(Icons.mail),
//                      hint: 'Actual Password',
//                      onSaved: (val) {
////                  email = val;
//                      },
//                    ),
//                    SizedBox(
//                      height: MediaQuery.of(context).size.height * 0.02,
//                    ),
                    CustomTextField(
                      controller: nP,
                      keyboardType: TextInputType.text,
                      validator: validator.password,
//                        icon: Icon(Icons.mail),
                      hint: 'New Password',
                      onSaved: (val) {
                        nP.text = val;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val != nP.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
//                        icon: Icon(Icons.mail),
                      hint: 'Repeat Password',
                      onSaved: (val) {
                        rP.text = val;
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
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            await emailAndPassWordAuth.changePassword(
                              password: nP.text,
                            );
                            if (emailAndPassWordAuth.passwordStatus == PasswordStatus.successful) {
                              showDialog(context: context,
                                barrierDismissible: false,
                                builder: (context) => Platform.isIOS ? CupertinoAlertDialog(
                                  content: Text(EmailAndPasswordAuth.message),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: (){
                                          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                        },
                                        child: Text('Ok'),
                                    ),
                                  ],
                                ) : AlertDialog(
                                  content: Text(EmailAndPasswordAuth.message),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: (){
                                        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                      },
                                      child: Text('Ok'),
                                    ),
                                  ],
                                )
                              );
                            }
                            else if (emailAndPassWordAuth.passwordStatus == PasswordStatus.failed) {
                              showDialog(
                                  context: context,
                                  builder: (context) => InValidUser(message: EmailAndPasswordAuth.message,)
                              );
                            }

                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Processing Data'),
                              ),
                            );
                          },
                          text: 'CHANGE PASSWORD',
                          elevation: 5.0,
                          color: Color(0xff003399),
                          textColor: Colors.white,
                        ),
                      ),
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
