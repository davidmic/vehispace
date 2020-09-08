import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

enum Status {uninitialized, unauthenticated, authenticating, authenticated}

class EmailAndPasswordAuth extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _store = Firestore.instance;
  bool isLoading;
  Status _status = Status.authenticating;

  Status get status => _status;

  set status (Status val) => _status = val;

  Future getCurrentUser() async {
    var user = await getCurrentUser();
    notifyListeners();
    return user;
  }

  // Sign in with Email and Password

  Future<FirebaseAuth> signInUser({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (err) {
      print(err.toString());
    }
    notifyListeners();
  }
 //Sign Up With Email and Password

  Future createNewUSer({String email, String password}) async {
    try {
     await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (err) {
      print(err.toString());
    }
    notifyListeners();
  }

  // UserDetails Management in Firestore,

  Future<bool> storeUser ({NewUser newuser})  async {
    try {
      status = Status.authenticating;
      notifyListeners();
    AuthResult result =  await _auth.createUserWithEmailAndPassword(email: newuser.email, password: newuser.passowrd);
//     AuthResult result = await createNewUSer(email: newuser.email, password: newuser.passowrd);
     FirebaseUser user = result.user;

      _store.collection('usermanagement').document(user.uid).setData({
         'uuid' : user.uid,
         'email' : newuser.email,
          'phone' : newuser.phoneNumber,
          'firstname' : newuser.firstName,
          'lastname' : newuser.lastName,
        });
//      notifyListeners();
      status = Status.authenticated;
      notifyListeners();
      return true;
    }
    catch (err) {
      print(err.toString());
      status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Sign out email and Password

  Future signOutUser () async {
    await _auth.signOut();
    notifyListeners();
  }
}
