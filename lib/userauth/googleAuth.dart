import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehispace/models/user.dart';
import 'package:intl/intl.dart';

enum GStatus {uninitialized, unauthenticated, authenticating, authenticated}

class GoogleAuth extends ChangeNotifier {
 final  GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _store = Firestore.instance;
  NewUser newUser = NewUser();
  GStatus _status = GStatus.authenticating;
  static String message;
  final format = DateFormat('dd-MM-yyyy');
  var now = DateTime.now();

  GStatus get status => _status;

  set status (GStatus val) => _status = val;

  Future<bool> handleSignIn({String userToken}) async {
    try{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      if (user == null) {
        message = 'Cancelled';
        status = GStatus.unauthenticated;
        notifyListeners();
        return false;
      }
        var v = user.displayName.split(" ");
        print ('User Display Name' + v.toString());
        print ('FirstName :' + v[0].toString());
        print ('LastName :' + v[1].toString());
        // print ('MiddleName :' + v[2].toString());

      var check = await _store.collection('usermanagement').document(user.uid).get();
      if (check.exists) {
        status = GStatus.authenticated;
      } else {
      _store.collection('usermanagement').document(user.uid).setData({
        
            'uuid' : user.uid,
            'email' : user.email,
            'phone' : user.phoneNumber.toString(),
            'firstname' : v[0].toString(),
            'lastname' : v[1].toString(),
            'country' : newUser.country ?? 'Nigeria',
            'state' : newUser.state,
            'localgovt' : newUser.lga,
            'referralcode' : newUser.referralCode,
            'createdDate' : format.format(now),
            'cardName' : '',
            'cardNumber' : '',
            'cvv' : '',
            'expiryDate' : '00/00',
            'hasCard' : false,
            'userToken' : userToken,
          });
      print("signed in " + user.displayName);
      print("signed in " + user.email);
      print("signed in " + user.phoneNumber.toString());
      print("signed in " + user.uid.toString());
      print("signed in " + user.photoUrl.toString());
      print('User Details' + user.toString());
      status = GStatus.authenticated;
      notifyListeners();
      }
      return true;
//     _store.collection('usermanagement').document()
    }
    catch (e) {
      print(e.toString());
      status = GStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  void handleSignOut () async {
    try {
      await _googleSignIn.signOut();
      print ('User Sign Out');
      notifyListeners();
    }catch (e) {
      print('Logout Google');
      notifyListeners();
    }
  }

  Future getCurrentUser() async {
    var user = await getCurrentUser();
    notifyListeners();
    return user;
  }

  Future<bool> signIn(String userToken) async {
    try{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;    
      if (user == null) {
        message = 'Cancelled';
        status = GStatus.unauthenticated;
        notifyListeners();
        return false;
      }
      status = GStatus.authenticated;
      var check = await _store.collection('usermanagement').document(user.uid).get();
         if (!check.exists) {
           status = GStatus.unauthenticated;
           message = 'User Account is not Registered';
         }else {
           status = GStatus.authenticated;
           await _store.collection('usermanagement').document(user.uid).updateData({
             'userToken' : userToken,
           });
            notifyListeners();
         }
      return true;
    }
  catch (e){
      message = e.code.toString().replaceAll("_", " ");
      }
    }
  }