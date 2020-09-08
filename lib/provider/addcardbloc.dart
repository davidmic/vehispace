import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vehispace/models/cardmodel.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;

enum cardStatus {Added, Failed}

class AddCardBloc extends ChangeNotifier {
  static String message;
  var _auth = FirebaseAuth.instance;
  var _store = Firestore.instance;
  cardStatus _status = cardStatus.Failed;

  get status => _status;
  set status (cardStatus val) => _status = val;
  
  addCard ({PaymentCardModel myCard}) async {
    final user = await _auth.currentUser();
    try {
      final userCardDetails = _store.collection('usermanagement').document(user.uid).updateData({
        'cardName' : myCard.name,
        'cardNumber' : myCard.number,
        'cvv' : myCard.cvv,
        'expiryDate' : myCard.expiryDate,
        'hasCard' : true,
      });
      status = cardStatus.Added;
      notifyListeners();
      return;
    }
    catch (e) {
      message = 'Failed to add Card... Try Again';
      status = cardStatus.Failed;
      notifyListeners();
      return;
    }
  }

  deleteCard ({PaymentCardModel myCard}) async {
    final user = await _auth.currentUser();
    try {
      final userCardDetails = _store.collection('usermanagement').document(user.uid).updateData({
        'cardName' : '',
        'cardNumber' : '',
        'cvv' : '',
        'expiryDate' : '00/00',
        'hasCard' : false,
      });
//      status = cardStatus.Added;
//      notifyListeners();
      return;
    }
    catch (e) {
      message = 'Failed';
//      status = cardStatus.Failed;
//      notifyListeners();
      return;
    }
  }
}


//final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
//final key = Key.fromUtf8('my 32 length key................');
//final iv = IV.fromLength(16);
//
//final encrypter = Encrypter(AES(key));
//
//final encrypted = encrypter.encrypt(plainText, iv: iv);
//final decrypted = encrypter.decrypt(encrypted, iv: iv);
//
//print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
//print(encrypted.base64);