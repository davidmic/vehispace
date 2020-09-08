// import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:http/http.dart' as http;
import 'package:vehispace/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

enum FBStatus {uninitialized, unauthenticated, authenticating, authenticated}

class FacebookAuth extends ChangeNotifier {
 
  // Facebook Login
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Firestore _store = Firestore.instance;

  FBStatus _status = FBStatus.authenticating;

  FBStatus get status => _status;

  set status (FBStatus val) => _status = val;

  static String message;
  final format = DateFormat('dd-mm-yyyy');
  var now = DateTime.now();

  NewUser _fbuser = NewUser();
  // EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();
  Future<Null> login({String userToken}) async {
    try {
      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
      if (result.status == FacebookLoginStatus.cancelledByUser) {
        status = FBStatus.unauthenticated;
        message = 'Cancelled';
        notifyListeners();
        return;
      }
        final accessToken = result.accessToken.token;
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
          accessToken: accessToken
        );
        final AuthResult authResult = await _auth.signInWithCredential(authCredential); 
        final FirebaseUser firebaseUser = authResult.user;


        print('NAME' + firebaseUser.displayName);
        print('NAME' + firebaseUser.email);
        print('NAME' + firebaseUser.phoneNumber.toString());
        print('NAME' + firebaseUser.photoUrl.toString());
        print('NAME' + firebaseUser.uid.toString());

      var v = firebaseUser.displayName.split(" ");
      print ('User Display Name' + v.toString());
      print ('FirstName :' + v[0].toString());
      print ('LastName :' + v[1].toString());
      // print ('MiddleName :' + v[2].toString());

      var check = await _store.collection('usermanagement').document(firebaseUser.uid).get();
      if (check.exists) {
        status = FBStatus.authenticated;
        return;
      } else {
     _store.collection('usermanagement').document(firebaseUser.uid).setData({
       
          'uuid' : firebaseUser.uid,
          'email' : firebaseUser.email,
          'phone' : firebaseUser.phoneNumber.toString(),
          'firstname' : v[0].toString(),
          'lastname' : v[1].toString(),
          'country' : _fbuser.country ?? 'Nigeria',
          'state' : _fbuser.state,
          'localgovt' : _fbuser.lga,
          'referralcode' : _fbuser.referralCode,
          'createdDate' : format.format(now),
          'cardName' : '',
          'cardNumber' : '',
          'cvv' : '',
          'expiryDate' : '00/00',
          'hasCard' : false,
          'userToken' : userToken,
        });
        print('Access Token');
        print(accessToken.toString());
        status = FBStatus.authenticated;
        notifyListeners();    
      }
    }
    catch (e) {
      message = e.code.toString().replaceAll("_", " ");
      status = FBStatus.unauthenticated;
    }
    
  }

  Future<bool> fblogOut() async {
    try{
      await facebookSignIn.logOut();
      notifyListeners();
    }
    catch (e) {
      print('facebook signout');
      notifyListeners();
    }
    return true;
  }


  Future getCurrentUser() async {
    var user = await getCurrentUser();
    notifyListeners();
    return user;
  }

  Future<Null> fblogin(String userToken) async {
    try {
      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
      if (result.status == FacebookLoginStatus.cancelledByUser) {
        status = FBStatus.unauthenticated;
        message = 'Cancelled';
        notifyListeners();
        return;
      }
        final accessToken = result.accessToken.token;
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
          accessToken: accessToken
        );
        final AuthResult authResult = await _auth.signInWithCredential(authCredential); 
        final FirebaseUser firebaseUser = authResult.user;
         var check = await _store.collection('usermanagement').document(firebaseUser.uid).get();
         if (!check.exists) {
           status = FBStatus.unauthenticated;
           message = 'User Account is not Registered';
         }else {
           status = FBStatus.authenticated;
           await _store.collection('usermanagement').document(firebaseUser.uid).updateData({
             'userToken' : userToken,
           });
            notifyListeners();
         }
       return;
}
  catch(e) {
       message = e.code.toString().replaceAll("_", " ");
       status = FBStatus.unauthenticated;
       notifyListeners();
       return;
    }
  }
}