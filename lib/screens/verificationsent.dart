import 'package:flutter/material.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/userauth/EmailAndPasswordAuth.dart';

class VerificationMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _emailandPasswordAuth = Provider.of<EmailAndPasswordAuth>(context);
    return Scaffold(
      body: Center  (
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('"\Thank you for registaring, A verification link has been sent to your email kindly verify your registration and continue\"',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Sansation',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              CustomRaisedButton(
                onPressed: (){
                   Navigator.pushReplacementNamed(context, '/verificationlogin');
                  }, 
                text: 'Verifed.. Click to Login',
                color: Color(0xff003399),
                textColor: Colors.white,
                borderColor: Color(0xff003399),
                borderWidth: 0.0,
                ),
            ]
          ),
        ),
        ),
    );
  }
}