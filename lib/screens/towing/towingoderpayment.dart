import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/cardmodel.dart';
import 'package:vehispace/models/towingmodel.dart';
import 'package:vehispace/provider/towingbloc.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/screens/towing/towinginfomap.dart';
import 'package:vehispace/services/paystack.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:vehispace/widgets/towingrequestcard.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TowingOrderPayment extends StatefulWidget {
  final Function onPressed;
  final Function editOnPressed;
  TowingOrderPayment({this.onPressed, this.editOnPressed});
  @override
  _TowingOrderPaymentState createState() => _TowingOrderPaymentState();
}

class _TowingOrderPaymentState extends State<TowingOrderPayment> {
  bool _saving = false;
  var _store = Firestore.instance;

  @override

 void initState() {
    super.initState();
    AppBarTitle().appBarTitle = 'Payment Options';
    PayStack().initializePayment();
  }
  @override

  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    var towingBloc = Provider.of<TowingBloc>(context);
    var userProfileBloc = Provider.of<UserProfile>(context);
    var payStackBloc = Provider.of<PayStack>(context);
    return
//      ModalProgressHUD(
//       inAsyncCall: _saving,
//        dismissible: false,
//        progressIndicator: Center(
//          child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                CircularProgressIndicator(),
//                SizedBox(height: 10,),
//                Text('Processing Payment ...', style: TextStyle(fontFamily: 'Sansation'),),
//              ]
//          ),
//        ),
//          child:
          StreamBuilder<DocumentSnapshot>(
            stream: _store.collection('towingRequest').document(userProfileBloc.userid).collection('request').document(userProfileBloc.userid+towingBloc.towingDetails.location+towingBloc.towingDetails.requestTime).snapshots(),
            builder: (context, snapshot) {
              var request = snapshot.data;
              Widget page;
                if (!snapshot.hasData) {
                 page = Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  height: 200.0,
                                  width: 200.0,
                                  child:
                                  CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Color(0xff003399)),
                                      strokeWidth: 5.0)
                              ),
                            SizedBox(height: 20,),
                            Text('Request is been processed'),
                        ],
                          ),
                        );
                }
                else if (snapshot.hasData) {
                  if (request['requestStatus'] == 'accept' && request['cost'] != 0) {
                    page = StreamBuilder<DocumentSnapshot>(
                      stream: _store.collection('usermanagement').document(userProfileBloc.userid).snapshots(),
                      builder: (context, snapshot) {
                        var cardData = snapshot.data;
                        Widget card;
                        if(!snapshot.hasData){
                          card = ListView(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.26),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 1,
                                            itemBuilder: (context, index) {
                                              return TowingRequestCard(
                                                title: 'Towing Service Requested',
                                                status: 'Status: Order is being processed',
                                                vehicleMake: towingBloc.towingDetails.vehicle,
                                                brand: towingBloc.towingDetails.brand,
                                                modelYear: towingBloc.towingDetails.model,
                                                location: towingBloc.towingDetails.location,
                                                destination: towingBloc.towingDetails.destination,
                                                conditionOfVehicle: towingBloc.towingDetails.conditionOfVehicle,
                                                casaulty: towingBloc.towingDetails.casualty,
                                                additionInfo: towingBloc.towingDetails.additionalInfo ?? '',
                                                dateTime: towingBloc.towingDetails.requestDate,
                                                onPressed: widget.editOnPressed,

                                              );
                                            }
                                        ),
                                      ),
                                      Center(child: Image.asset('assets/images/Asset4.png')),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'Payment made for towing services are not refundable',
                                      style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontStyle: FontStyle.normal, fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Towing Cost',
                                          style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontStyle: FontStyle.normal, fontSize: 16),
                                        ),
                                        Text(
                                          request['cost'].toString(),
                                          style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontStyle: FontStyle.normal, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomTextField(
                                      suffixIcon: Image.asset('assets/images/cardtypea.png'),
                                      hint: 'No Card',
                                      readOnly: true,
                                      labelText: 'Pay with Card',
                                      onSaved: (val) {},
                                      keyboardType: TextInputType.text,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'Field is Required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  _saving ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator(backgroundColor: Color(0xff003399),),
                                    ],
                                  ) : Container(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.93,
                                    child: CustomRaisedButton(
                                      onPressed: () async {},
                                      text: 'PAY NOW',
                                      textColor: Colors.white,
                                      color: Color(0xff003399),
                                    ),
                                  ),
                                  SizedBox(height:50),
                                ],
                              ),
                            ],
                          );
                        } else if (snapshot.hasData) {
                          card = ListView(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.28),
                                        child: ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 1,
                                            itemBuilder: (context, index) {
                                              return TowingRequestCard(
                                                title: 'Towing Service Requested',
                                                status: 'Status: Order is being processed',
                                                vehicleMake: towingBloc.towingDetails.vehicle,
                                                brand: towingBloc.towingDetails.model,
                                                modelYear: towingBloc.towingDetails.year,
                                                location: towingBloc.towingDetails.location,
                                                destination: towingBloc.towingDetails.destination,
                                                conditionOfVehicle: towingBloc.towingDetails.conditionOfVehicle,
                                                casaulty: towingBloc.towingDetails.casualty,
                                                additionInfo: towingBloc.towingDetails.additionalInfo ?? '',
                                                dateTime: towingBloc.towingDetails.requestDate,
                                                onPressed: widget.editOnPressed,

                                              );
                                            }
                                        ),
                                      ),
                                      Center(child: Image.asset('assets/images/Asset4.png')),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'Payment made for towing services are not refundable',
                                      style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontStyle: FontStyle.normal, fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Towing Cost',
                                          style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontStyle: FontStyle.normal, fontSize: 16),
                                        ),
                                        Text(
                                          '\u{20A6}' + request['cost'].toString(),
                                          style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontStyle: FontStyle.normal, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomTextField(
                                      suffixIcon: Image.asset('assets/images/cardtypea.png'),
                                      hint: cardData['cardNumber'] ?? '',
                                      intialValue: cardData['cardNumber'] ?? '',
                                      readOnly: true,
                                      labelText: 'Pay with Card',
                                      onSaved: (val) {},
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  _saving ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator(backgroundColor: Color(0xff003399),),
                                    ],
                                  ) : Container(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.93,
                                    child: CustomRaisedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _saving = true;
                                        });
                                        await payStackBloc.checkoutPaystackWithCard(
                                            context: context,
                                            userId: userProfileBloc.userid,
                                            userToken: userProfileBloc.userToken,
                                            docId: request.documentID,
                                            firstName: userProfileBloc.firstName,
                                            lastName: userProfileBloc.lastName,
                                            amount: request['cost'].toString(),
                                            mycard: PaymentCardModel(
                                              number: cardData['cardNumber'],
                                              cvv: cardData['cvv'],
                                              expiryDate: cardData['expiryDate'],
                                              name: cardData['cardName'],
                                              email: cardData['email'],
                                            ),
                                        );
                                        setState(() {
                                          _saving = false;
                                        });
                                        print('i was tapped');
                                        if (payStackBloc.status == PaymentState.Successful){
                                          showDialog(
                                              context: context,
                                              builder: (context){
                                                 Future.delayed(Duration(seconds: 2), () {
                                                   Navigator.of(context).pop();
                                                 });
                                                return PaymentSuccessful();
                                              }
                                          );
                                          widget.onPressed();
                                        }
                                        else if (payStackBloc.status == PaymentState.Failed) {
                                          showDialog(
                                            context: context,
                                            builder: (context){
                                              // Future.delayed(Duration(seconds: 2), () {
                                              //   Navigator.of(context).pop();
                                              // });
                                              return InValidUser(message: 'Failed',);
                                            }
                                         );
                                        }

                                      },
                                      text: 'PAY NOW',
                                      textColor: Colors.white,
                                      color: Color(0xff003399),
                                    ),
                                  ),
                                  SizedBox(height:50),
                                ],
                              ),
                            ],
                          );
                        }
                        return card;
                      }
                    );

                  }
                  else if (request['requestStatus'] == 'decline') {
                    page = Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.error, color: Colors.red, size: 30,),
                          SizedBox(height: 20,),
                          Text('Towing Request Failed.. Try Again'),
                          SizedBox(height: 20,),
                          CustomRaisedButton(
                            color: Colors.white,
                            borderColor: Color(0xff003399),
                            text: 'Go Back',
                            textColor: Color(0xff003399),
                            onPressed: (){
                              widget.editOnPressed();
                            },
                          )
                        ],
                      ),
                    );

                  }
                  else if (request['requestStatus'] == 'processing'){
                    page = Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: 200.0,
                              width: 200.0,
                              child:
                              CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Color(0xff003399)),
                                  strokeWidth: 5.0)
                          ),
                          SizedBox(height: 20,),
                          Text('Request is been processed'),
                        ],
                      ),
                    );
                  }
                }
              return page;

            }
          );
  }
}


//              setState(() {
//                _saving = true;
//              });
// Future.delayed(Duration(seconds: 5));
//                                  await towingBloc.storeTowingRequest(
//                                      towingModel: TowingModel(
//                                        country: towingBloc.towingDetails.country,
//                                        state: towingBloc.towingDetails.state,
//                                        lga: towingBloc.towingDetails.lga,
//                                        vehicle: towingBloc.towingDetails.vehicle,
//                                        brand: towingBloc.towingDetails.brand,
//                                        model: towingBloc.towingDetails.model,
//                                        location: towingBloc.towingDetails.location,
//                      latitude: towingBloc.towingDetails.latitude,
//                      longitude: towingBloc.towingDetails.longitude,
//                                        destination: towingBloc.towingDetails.destination,
//                      destLatitude: towingBloc.towingDetails.destLatitude,
//                      destLongitude: towingBloc.towingDetails.destLongitude,
//                                        conditionOfVehicle: towingBloc.towingDetails.conditionOfVehicle,
//                                        casualty: towingBloc.towingDetails.casualty,
//                                        additionalInfo: towingBloc.towingDetails.additionalInfo ?? '',
//                                        requestTime: towingBloc.towingDetails.requestTime,
//                                        requestDate: towingBloc.towingDetails.requestDate,
//                                      )
//                                  );
//                                  print('i was tapped again');
//                                  setState(() {
//                                    _saving = false;
//                                  });
//                                  if (towingBloc.request == Request.sent) {
//                                    showDialog(
//                                        context: context,
//                                        builder: (context){
//                                          // Future.delayed(Duration(seconds: 2), () {
//                                          //   Navigator.of(context).pop();
//                                          // });
//                                          return PaymentSuccessful();
//                                        }
//                                    );
//                                    print('i was tapped again again');
//                                    print('i was tapped');
//                                  }
//                                  else if (towingBloc.request == Request.notSent) {
//                                    print('i was tapped i failed');
//
//                                    showDialog(
//                                        context: context,
//                                        builder: (context){
//                                          // Future.delayed(Duration(seconds: 2), () {
//                                          //   Navigator.of(context).pop();
//                                          // });
//                                          return InValidUser(message: 'Failed',);
//                                        }
//                                    );
//                                  }