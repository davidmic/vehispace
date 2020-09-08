import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookAuth extends ChangeNotifier {
 // Facebook Login

 static final FacebookLogin facebookSignIn = new FacebookLogin();

 String _message = 'Log in/out by pressing the buttons below.';

 Future<Null> login() async {
//    facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
   final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

   switch (result.status) {
     case FacebookLoginStatus.loggedIn:
       final FacebookAccessToken accessToken = result.accessToken;
       _showMessage('''
        Logged in!
        Token: ${accessToken.token}
        User id: ${accessToken.userId}
        Expires: ${accessToken.expires}
        Permissions: ${accessToken.permissions}
        Declined permissions: ${accessToken.declinedPermissions}
        ''');
       break;
     case FacebookLoginStatus.cancelledByUser:
       _showMessage('Login cancelled by the user.');
       break;
     case FacebookLoginStatus.error:
       _showMessage
         ('Something went wrong with the login process.\n'
           'Here\'s the error Facebook gave us: ${result.errorMessage}'
       );
       break;
   }
 }

 Future<Null> logOut() async {
   await facebookSignIn.logOut();
   _showMessage('Logged out.');
 }

 void _showMessage(String message) {
   _message = message;
   print(_message);
   notifyListeners();
 }

}