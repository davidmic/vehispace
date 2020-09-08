import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

enum EStatus {uninitialized, unauthenticated, authenticating, authenticated, emailresend}
enum PasswordStatus {successful, failed}

class EmailAndPasswordAuth extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _store = Firestore.instance;
  EStatus _status = EStatus.uninitialized;
  PasswordStatus _passwordStatus = PasswordStatus.failed;
  static var message;
  String v;


  EStatus get status => _status;
  set status (EStatus val) => _status = val;

  PasswordStatus get passwordStatus => _passwordStatus;
  set passwordStatus (PasswordStatus val) => _passwordStatus = val;

 Future <FirebaseUser> getCurrentUser() async {
    var user = await _auth.currentUser();
    print('My User Id');
    print(user.uid.toString());
    notifyListeners();
    return user;
  }

  // Sign in with Email and Password

  Future<FirebaseAuth> signInUser({String email, String password}) async {
    try {
     final  user = await _auth.signInWithEmailAndPassword(email: email, password: password);
     final userResult = user.user;
     if (userResult.isEmailVerified) {
         status = EStatus.authenticated;
         notifyListeners();
     }else {
       await userResult.sendEmailVerification();
       status = EStatus.emailresend;
       notifyListeners();
     } 
  } catch (err) {
      print(err.code.toString());
      errorMessage(errMessage: err.code);
      // message = (err.code.toString().replaceAll("_", " "));
      // print('My Error Message' + message);
      // message = err.toString();
      status = EStatus.unauthenticated;
      notifyListeners();
    }
  }
 
  Future<bool> storeUser ({NewUser newuser})  async {
    try {
    
    AuthResult result =  await _auth.createUserWithEmailAndPassword(email: newuser.email, password: newuser.passoword);
       
    

     FirebaseUser user = result.user;
     await user.sendEmailVerification();
    
      _store.collection('usermanagement').document(user.uid).setData({
          'uuid' : user.uid,
          'email' : newuser.email,
          'phone' : newuser.phoneNumber,
          'firstname' : newuser.firstName,
          'lastname' : newuser.lastName,
          'country' : newuser.country,
          'state' : newuser.state,
          'localgovt' : newuser.lga,
          'referralcode' : newuser.referralCode,
          'createdDate' : newuser.createdDate,
        });
      status = EStatus.authenticated;
      notifyListeners();
      return true;
    }
    catch (err) {
      message = (err.code.toString().replaceAll("_", " "));
      status = EStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Sign out email and Password

  Future signOutUser () async {
    await _auth.signOut();
    notifyListeners();
  }

  Future <void> resetPassword (String email) async {
    try {
       await _auth.sendPasswordResetEmail(email: email);
       message = 'Password Reset, check your mail';
      notifyListeners();
    }
    catch(e) {
      print(e.code);
      message = e.code.toString().replaceAll("_", " ");
    }
  }

  Future changePassword ({String password}) async {
    try {
      final user = await _auth.currentUser();
      user.updatePassword(password);
      message = 'Password Changed Successfully, Please Re-Login';
      passwordStatus = PasswordStatus.successful;
      notifyListeners();
      return;
    }
    catch (e) {
      message = e.code.toString().replaceAll("_", " ").toLowerCase();
      passwordStatus = PasswordStatus.successful;
      notifyListeners();
      return;
    }
  } 

  String errorMessage ({String errMessage}) {
  switch (errMessage) {
    case 'ERROR_INVALID_EMAIL':
     message = 'Your email address appears to be malformed';
     break;
    case 'ERROR_WRONG_PASSWORD':
     message = 'Your password is incorrect';
     break;
    case 'ERROR_USER_NOT_FOUND':
     message = 'User with this Email does not exit';
     break;
    case 'ERROR_USER_NOT_DISABLED':
     message = 'User with this Email has been disabled';
     break; 
    case 'ERROR_TOO_MANY_REQUESTS':
     message = 'Too many requests. Try again later';
     break;
    case 'ERROR_OPERATION_NOT_ALLOWED':
     message = 'Signing in with email and password is not allowed';
     break; 
    default:
      message = "Error... Try Again"; 
  }
}

}

