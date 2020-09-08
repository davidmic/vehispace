import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehispace/models/user.dart';

enum Update {uninitialized, success, failed}

class UserProfile extends ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore store = Firestore.instance;
  String _userid;
  Update _status = Update.uninitialized;

  get status => _status;
  set status (val) => _status = val;
  String get userid => _userid;
  set userid (String value) => _userid = value;
  static String message;

  Future getCurrentUser () async {
    try {
      final user =  await auth.currentUser();
      _userid = user.uid;
      print('tehhbdjsj shdhdhsjs');
      print(_userid);
      notifyListeners();
      return;
    }
    catch (e) {
      print (e.toString());
    }
  }

  Future upadteUserDetails({NewUser user}) async {
    try {
      final userData = await store.collection('usermanagement').document(userid).updateData({
      'firstname' : user.firstName,
      'lastname' : user.lastName,
      'email' : user.email,
      'gender' : user.gender,
      'driverlicense' : user.driverLicense,
      'driverlicenseexpiry' : user.driverLicenseExpiry,
      });
      status = Update.success;
      notifyListeners();
      return;
    } catch (e) {
      message = e.code.toString().replaceAll("_", " ");
      print (message);
      status = Update.failed;
      notifyListeners();
      return;
    }
    
  }

  Future updateUserPhoto ({NewUser user}) async {
    try {
      final userPhoto = await store.collection('usermanagement').document(userid).updateData({
        'imageURL' : user.imageURL,
      });
      status = Update.success;
      notifyListeners();
      return;
    }
    catch (e) {
      message = e.code.toString().replaceAll("_", " ");
      status = Update.failed;
      notifyListeners();
    }
  }

}