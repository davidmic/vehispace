import 'package:flutter/material.dart';
import '../widgets/customtextformfield.dart';
import '../widgets/customraisedbutton.dart';
import '../models/user.dart';
import '../utils/validator.dart';
import 'package:provider/provider.dart';
import '../userauth/facebookauth.dart';
import '../userauth/EmailAndPasswordAuth.dart';
import '../userauth/googleAuth.dart';

class MyLoginScreen extends StatefulWidget {
//  static String id = '/login';
  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  var _formkey = GlobalKey<FormState>();
  String email;
  String pass;
  User user = User.create();
  MyValidator validator = MyValidator();
  @override
  Widget build(BuildContext context) {
    final FacebookAuth facebookAuth = Provider.of<FacebookAuth>(context);
    final EmailAndPasswordAuth emailAndPasswordAuth = Provider.of<EmailAndPasswordAuth>(context);
    // final GoogleAuth googleAuth = Provider.of<GoogleAuth>(context);
    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          'Sign Up',
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
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Processing Data'),
                              ),
                            );
                            user.email = email;
                            user.password = pass;
                            print(user.email);
                            print(user.password);
                            await emailAndPasswordAuth.signInUser(
                              email: email,
                              password: pass,
                            );
                            Navigator.pushNamed(context, '/offerservices');
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
                          onTap: () {
//                            facebookAuth.login();
                            // Navigator.pushNamed(context, '/offerservices');
                            print('Login with facebook');
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
                            'Don\'t have an account? Register',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Sansation',
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
