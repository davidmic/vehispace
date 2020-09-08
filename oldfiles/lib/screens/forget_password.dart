import 'package:flutter/material.dart';
import '../widgets/customraisedbutton.dart';
import '../widgets/customtextformfield.dart';
import '../utils/validator.dart';
import '../utils/constants.dart';

class MyForgotPassword extends StatelessWidget {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  MyValidator validator = MyValidator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          'Password Reset',
//          style: TextStyle(color: Colors.black),
//        ),
//        backgroundColor: Colors.white,
//        iconTheme: IconThemeData(
//          color: Colors.black,
//        ),
//      ),
      body: Form(
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
//                        email = val;
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
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Processing Data'),
                              ),
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
    );
  }
}
