//import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class GoogleAuth extends ChangeNotifier {
//  GoogleSignIn _googleSignIn = GoogleSignIn();
//  FirebaseAuth _auth = FirebaseAuth.instance;
//  Firestore _store = Firestore.instance;
//
//  Future<FirebaseUser> handleSignIn() async {
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//
//    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
//    print("signed in " + user.displayName);
//    print('User Details' + user.toString());
//
////     _store.collection('usermanagement').document()
//
//    return user;
//  }
////  _handleSignIn()
////      .then((FirebaseUser user) => print(user))
////      .catchError((e) => print(e));
//
//}