import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:vehispace/models/cardmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehispace/models/vehiclepapers.dart';
import 'package:vehispace/provider/vehiclepapersbloc.dart';

enum PaymentState {Successful, Failed}

class PayStack extends ChangeNotifier{
  var publicKey = 'pk_test_8560344a232413f21dc4dac53eb94d18d54fa4bb';
//    var publicKey = 'pk_live_b7cd61841cc4d44181aa087ec689208d29e9f135';
  Firestore _store = Firestore.instance;
  var _auth = FirebaseAuth.instance;

  PaymentState _status = PaymentState.Failed;

  get status => _status;

  set status (PaymentState val) => _status = val;

  Charge charge = Charge();

  initializePayment() async {
    await PaystackPlugin.initialize(publicKey: publicKey);
  }

   checkoutPaystack(context) async {
    charge.amount = 20000000;
    charge.email = 'johndoe@maill.com';
    charge.reference = _getReference();
    charge.putCustomField('Charged From', 'Vehispace');
    try {
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
//        logo: MyLogo(),
      );
      print('Response = $response');
//      setState(() => _inProgress = false);
//      _updateStatus(response.reference, '$response');
    } catch (e) {
//      setState(() => _inProgress = false);
//      _showMessage("Check console for error");
      rethrow;
    }
    await PaystackPlugin.chargeCard(
        context,
        charge: charge,
//        beforeValidate: null,
        onSuccess: (tans) {
          print(tans);
          print('success');
        },
        onError: (e, trans) {
          if (e is ExpiredAccessCodeException){
            return;
          }
        }
    );
  }

  checkoutPaystackWithCard({context, PaymentCardModel mycard, String amount, String userId, String docId, String firstName, String lastName, String userToken}) async {
    var expiryDate = mycard.expiryDate.split('/');
    int month = int.parse(expiryDate[0].trim()) ;
    int year = int.parse(expiryDate[1].trim());
    var camount = amount + '00';
    charge.amount =  int.parse(camount);
    charge.email = mycard.email ?? 'johndoe@maill.com';
    charge.reference = _getReference();
    charge.putCustomField('Charged From', 'Vehispace');
    charge.card = PaymentCard(
        number: mycard.number,
        cvc: mycard.cvv,
        expiryMonth: month,
        expiryYear: year,
        name: mycard.name ?? '',
    );
      try {
        CheckoutResponse response = await PaystackPlugin.checkout(
          context,
          method: CheckoutMethod.card,
          charge: charge,
          fullscreen: false,
          logo: Image.asset('assets/logo/mylogo.png'),
        );
        print('Response = $response');
        if (response.status == true){
          print(response.status);
          print(response.verify);
          print(response.reference);
          await _store.collection('towingRequest').document(userId).collection('request').document(docId).updateData({
              'paymentStatus' : 'Successful',
              'paymentResponse' : response.status,
              'paymentReference' : response.reference,
          });
          await _store.collection('payments').document('towingRequest').collection('successfulpayment').document(docId).setData({
            'userId' : userId,
            'userName' : firstName + " " + lastName,
            'userEmail' : mycard.email,
            'paymentStatus' : 'Successful',
            'paymentResponse' : response.status,
            'paymentReference' : response.reference,
            'cost' : amount,
            'userToken' : userToken,
          });
          status = PaymentState.Successful;
          notifyListeners();
          return;
        } else if (response.status == false) {
          print('Transaction Failed');
          await _store.collection('towingRequest').document(userId).collection('request').document(docId).updateData({
            'paymentStatus' : 'Failed',
            'paymentResponse' : response.status,
            'paymentReference' : response.reference,
          });
          await _store.collection('payments').document('towingRequest').collection('failedpayment').document(docId).setData({
            'userId' : userId,
            'userName' : firstName + " " + lastName,
            'userEmail' : mycard.email,
            'paymentStatus' : 'Failed',
            'paymentResponse' : response.status,
            'paymentReference' : response.reference,
            'userToken' : userToken,
          });
          status = PaymentState.Failed;
          notifyListeners();
          return;
        }
      } catch (e) {
        print(e.toString());
        rethrow;
      }


//      await PaystackPlugin.chargeCard(
//          context,
//          charge: charge,
//          onSuccess: (tans) {
//            print(tans);
//            print('the rans success');
//            status = PaymentState.Successful;
//            notifyListeners();
//            return;
//          },
//          onError: (e, trans) {
//            if (e is ExpiredAccessCodeException) {
//              status = PaymentState.Failed;
////              notifyListeners();
//              return;
//            }
//          }
//      );
//      status = PaymentState.Successful;
//      notifyListeners();
//      return;
//      print('got an error');
//      status = PaymentState.Failed;
////      notifyListeners();
//      return;
  }

  checkoutPaystackVehiclePapers({context, PaymentCardModel mycard, String amount, String userId, String docId, String firstName, String lastName, VehiclePapersModel vehiclePapersModel, String userToken}) async {
    var expiryDate = mycard.expiryDate.split('/');
    int month = int.parse(expiryDate[0].trim()) ;
    int year = int.parse(expiryDate[1].trim());
    var camount = amount + '00';
    charge.amount =  int.parse(camount);
    charge.email = mycard.email ?? 'johndoe@maill.com';
    charge.reference = _getReference();
    charge.putCustomField('Charged From', 'Vehispace');
    charge.card = PaymentCard(
      number: mycard.number,
      cvc: mycard.cvv,
      expiryMonth: month,
      expiryYear: year,
      name: mycard.name ?? '',
    );
    try {
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
        logo: Image.asset('assets/logo/mylogo.png'),
      );
      print('Response = $response');
      if (response.status == true){
        print(response.status);
        print(response.verify);
        print(response.reference);
        VehiclePaperBloc().storeVehicleRenewalRequest(
          vehiclePaperData: VehiclePapersModel(
            country: vehiclePapersModel.country,
            state: vehiclePapersModel.state,
            pin: vehiclePapersModel.pin,
            registrationNumber: vehiclePapersModel.registrationNumber,
            engineNumber: vehiclePapersModel.engineNumber,
            vehicleMake: vehiclePapersModel.vehicleMake,
            colour: vehiclePapersModel.colour,
            engineCapacity: vehiclePapersModel.engineCapacity,
            transactionDate: vehiclePapersModel.transactionDate,
            expiryDate: vehiclePapersModel.expiryDate,
            dateIssued: vehiclePapersModel.dateIssued,
            roadWorthiness: vehiclePapersModel.roadWorthiness,
            roadWorthinessType: vehiclePapersModel.roadWorthinessType,
            insuranceRenewal: vehiclePapersModel.insuranceRenewal,
            insuranceRenewalType: vehiclePapersModel.insuranceRenewalType,
            requestTime: vehiclePapersModel.requestTime,
            requestDate: vehiclePapersModel.requestDate,
            vehicleId: vehiclePapersModel.vehicleId,
            userToken: vehiclePapersModel.userToken,
          ),
          paymentReference: response.reference,
          paymentResponse: response.status,
          paymentStatus: 'Successful',
          cost: amount
        );
        await _store.collection('payments').document('vehiclePapersRenewal').collection('successfulpayment').document(docId).setData({
          'userId' : userId,
          'userName' : firstName + " " + lastName,
          'userEmail' : mycard.email,
          'paymentStatus' : 'Successful',
          'paymentResponse' : response.status,
          'paymentReference' : response.reference,
          'cost' : amount,
          'userToken' : userToken,
        });
        status = PaymentState.Successful;
        notifyListeners();
        return;
      } else if (response.status == false) {
        print('Transaction Failed');
//        await _store.collection('vehiclerenewalrequest').document(userId).collection('request').document(docId).updateData({
//          'paymentStatus' : 'Failed',
//          'paymentResponse' : response.status,
//          'paymentReference' : response.reference,
//        });
        await _store.collection('payments').document('vehiclePaperRenewal').collection('failedpayment').document(docId).setData({
          'userId' : userId,
          'userName' : firstName + " " + lastName,
          'userEmail' : mycard.email,
          'paymentStatus' : 'Failed',
          'paymentResponse' : response.status,
          'paymentReference' : response.reference,
          'userToken' : userToken,
        });
        status = PaymentState.Failed;
        notifyListeners();
        return;
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }


//      await PaystackPlugin.chargeCard(
//          context,
//          charge: charge,
//          onSuccess: (tans) {
//            print(tans);
//            print('the rans success');
//            status = PaymentState.Successful;
//            notifyListeners();
//            return;
//          },
//          onError: (e, trans) {
//            if (e is ExpiredAccessCodeException) {
//              status = PaymentState.Failed;
////              notifyListeners();
//              return;
//            }
//          }
//      );
//      status = PaymentState.Successful;
//      notifyListeners();
//      return;
//      print('got an error');
//      status = PaymentState.Failed;
////      notifyListeners();
//      return;
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime
        .now()
        .millisecondsSinceEpoch}';
  }

}

