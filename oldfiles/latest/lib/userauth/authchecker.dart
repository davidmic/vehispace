
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValidUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dialogBackgroundColor: Colors.white),
      child: SimpleDialog(
              title: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff003399)
                      ),
                      child: Icon(
                        Icons.check,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Success!', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'Sansation', fontStyle: FontStyle.normal), ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }
}

class InValidUser extends StatelessWidget {
   InValidUser({this.message: 'User not Authenticated'});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Theme(
         data: ThemeData(dialogBackgroundColor: Colors.white),
          child: SimpleDialog(
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff003399)
                      ),
                      child: Icon(
                        Icons.close,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(message, softWrap: true, style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'Sansation', fontStyle: FontStyle.normal), )),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
      ),
    );
  }
}

class UserNotVerified extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(dialogBackgroundColor: Colors.white),
          child: SimpleDialog(
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff003399)
                      ),
                      child: Icon(
                        Icons.warning,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('User is not yet Verified', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'Sansation', fontStyle: FontStyle.normal), ),
                     SizedBox(height: 10,),
                  ],
                ),
              ),
      ),
    );
  }
}


class PaymentSuccessful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dialogBackgroundColor: Colors.white),
      child: SimpleDialog(
              title: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff003399)
                      ),
                      child: Icon(
                        Icons.check,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Payment Successful', style: TextStyle(color: Color(0xff003399), fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sansation', fontStyle: FontStyle.normal), ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }
}

class AddCardSuccessful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dialogBackgroundColor: Colors.white),
      child: SimpleDialog(
              title: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff003399)
                      ),
                      child: Icon(
                        Icons.check,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Your Credit Card has been successfully added', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sansation', fontStyle: FontStyle.normal), ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }
}