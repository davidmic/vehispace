import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/cardmodel.dart';
import 'package:vehispace/models/vehiclepapers.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/provider/vehiclepapersbloc.dart';
import 'package:vehispace/services/paystack.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:vehispace/widgets/vehiclepaperscard.dart';

class VehiclePapersPayment extends StatefulWidget {
  final Function onPressed;
  final Function editOnPressed;
  VehiclePapersPayment({this.onPressed, this.editOnPressed});
  @override
  _VehiclePapersPaymentState createState() => _VehiclePapersPaymentState();
}

class _VehiclePapersPaymentState extends State<VehiclePapersPayment> {
  var _store = Firestore.instance;
  bool _saving = false;
  var cardData;
  @override

  void initState () {
    super.initState();
    PayStack().initializePayment();
  }
  @override

  Widget build(BuildContext context) {
    var vehiclePaperBloc = Provider.of<VehiclePaperBloc>(context);
    var userProfileBloc = Provider.of<UserProfile>(context);
    var payStackBloc = Provider.of<PayStack>(context);
    return StreamBuilder<DocumentSnapshot>(
      stream: _store.collection('usermanagement').document(userProfileBloc.userid).snapshots(),
      builder: (context, snapshot) {
        return ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
            // fit: StackFit.expand,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.26),
                child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return VehiclePaperRequestCard(
                    vehicleMake: vehiclePaperBloc.vehiclePaperModel.vehicleMake,
                    registrationNumber: vehiclePaperBloc.vehiclePaperModel.registrationNumber,
                    engineNumber: vehiclePaperBloc.vehiclePaperModel.engineNumber,
                    engineCapacity: vehiclePaperBloc.vehiclePaperModel.engineCapacity,
                    roadWorthiness: vehiclePaperBloc.vehiclePaperModel.roadWorthiness,
                    insuranceRenewal: vehiclePaperBloc.vehiclePaperModel.insuranceRenewalType,
                    dateTime: vehiclePaperBloc.vehiclePaperModel.requestDate,
                    onPressed: widget.editOnPressed,
                  );
                }
             ),
              ),
              Center(child: Image.asset('assets/images/Asset3.png')),
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
                 child: BuildCostSummary(
                   title: 'License Cost',
                   cost: '\u{20A6}'+vehiclePaperBloc.vehiclePaperModel.vehicleLicensePrice.toString(),
                 ),
               ),
                vehiclePaperBloc.vehiclePaperModel.roadWorthiness == 'Yes' ? Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: BuildCostSummary(
                   title: 'Road Worthiness Renewal',
                   cost: '\u{20A6}'+vehiclePaperBloc.vehiclePaperModel.roadWorthinessPrice.toString(),
                 ),
               ) : Container(),
                vehiclePaperBloc.vehiclePaperModel.insuranceRenewal == 'Yes' ? Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: BuildCostSummary(
                   title: 'Insurance Renewal',
                   cost: '\u{20A6}'+vehiclePaperBloc.vehiclePaperModel.insuranceRenewalPrice.toString(),
                 ),
               ) : Container(),
                Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: BuildCostSummary(
                   title: 'Delivery Fee',
                   cost: '\u{20A6}'+VehiclePaperBloc.deliverycost.toString(),
                 ),
               ),
                Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Divider(color: Color(0xffff0000),),
               ),
                Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: BuildCostSummary(
                   title: 'Total',
                   cost:  '\u{20A6}${vehiclePaperBloc.vehiclePaperModel.vehicleLicensePrice+vehiclePaperBloc.vehiclePaperModel.roadWorthinessPrice+vehiclePaperBloc.vehiclePaperModel.insuranceRenewalPrice+VehiclePaperBloc.deliverycost}',
                 ),
               ),
                StreamBuilder<DocumentSnapshot>(
                    stream: _store.collection('usermanagement').document(userProfileBloc.userid).snapshots(),
                  builder: (context, snapshot) {
                      Widget card;
                      cardData = snapshot.data;
                      if (!snapshot.hasData){
                        card = Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomTextField(
                            suffixIcon: Image.asset('assets/images/cardtypea.png'),
                            hint: "No Card",
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
                        );
                      }
                      else if (snapshot.hasData) {
                        card = Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomTextField(
                            suffixIcon: Image.asset('assets/images/cardtypea.png'),
                            hint: cardData['cardNumber'] ?? 'No Card',
                            intialValue: cardData['cardNumber'] ?? '',
                            readOnly: true,
                            labelText: 'Pay with Card',
                            onSaved: (val) {},
                            keyboardType: TextInputType.text,
                          ),
                        );
                      }
                    return card;
                  }
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                _saving ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(backgroundColor: Color(0xff003399),),
                    ],
                  ),
                ) : Container(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                  child: CustomRaisedButton(
                  onPressed: () async {
                    String amount = (vehiclePaperBloc.vehiclePaperModel.vehicleLicensePrice+vehiclePaperBloc.vehiclePaperModel.roadWorthinessPrice+vehiclePaperBloc.vehiclePaperModel.insuranceRenewalPrice+VehiclePaperBloc.deliverycost).toString();
                    setState(() {
                      _saving = true;
                    });
                     await payStackBloc.checkoutPaystackVehiclePapers(
                       context: context,
                      userId: userProfileBloc.userid,
                       amount: amount,
                       firstName: userProfileBloc.firstName,
                       lastName: userProfileBloc.lastName,
                       docId: vehiclePaperBloc.vehiclePaperModel.registrationNumber + vehiclePaperBloc.vehiclePaperModel.requestTime,
                       mycard: PaymentCardModel(number: cardData['cardNumber'],
                       cvv: cardData['cvv'],
                       expiryDate: cardData['expiryDate'],
                       name: cardData['cardName'],
                       email: cardData['email'],
                     ),
                       userToken: userProfileBloc.userToken,
                       vehiclePapersModel: VehiclePapersModel(
                       country: vehiclePaperBloc.vehiclePaperModel.country,
                       state: vehiclePaperBloc.vehiclePaperModel.state,
                       pin: vehiclePaperBloc.vehiclePaperModel.pin,
                       registrationNumber: vehiclePaperBloc.vehiclePaperModel.registrationNumber,
                       engineNumber: vehiclePaperBloc.vehiclePaperModel.engineNumber,
                       vehicleMake: vehiclePaperBloc.vehiclePaperModel.vehicleMake,
                       colour: vehiclePaperBloc.vehiclePaperModel.colour,
                       engineCapacity: vehiclePaperBloc.vehiclePaperModel.engineCapacity,
                       transactionDate: vehiclePaperBloc.vehiclePaperModel.transactionDate,
                       expiryDate: vehiclePaperBloc.vehiclePaperModel.expiryDate,
                       dateIssued: vehiclePaperBloc.vehiclePaperModel.dateIssued,
                       roadWorthiness: vehiclePaperBloc.vehiclePaperModel.roadWorthiness,
                       roadWorthinessType: vehiclePaperBloc.vehiclePaperModel.roadWorthinessType,
                       insuranceRenewal: vehiclePaperBloc.vehiclePaperModel.insuranceRenewal,
                       insuranceRenewalType: vehiclePaperBloc.vehiclePaperModel.insuranceRenewalType,
                       requestTime: vehiclePaperBloc.vehiclePaperModel.requestTime,
                       requestDate: vehiclePaperBloc.vehiclePaperModel.requestDate,
                       vehicleId: vehiclePaperBloc.vehiclePaperModel.registrationNumber + vehiclePaperBloc.vehiclePaperModel.requestTime,
                        userToken: userProfileBloc.userToken
                     )
                    );
//                await vehiclePaperBloc.storeVehicleRenewalRequest(
//                    vehiclePaperData: VehiclePapersModel(
//                      country: vehiclePaperBloc.vehiclePaperModel.country,
//                      state: vehiclePaperBloc.vehiclePaperModel.state,
//                      pin: vehiclePaperBloc.vehiclePaperModel.pin,
//                      registrationNumber: vehiclePaperBloc.vehiclePaperModel.registrationNumber,
//                      engineNumber: vehiclePaperBloc.vehiclePaperModel.engineNumber,
//                      vehicleMake: vehiclePaperBloc.vehiclePaperModel.vehicleMake,
//                      colour: vehiclePaperBloc.vehiclePaperModel.colour,
//                      engineCapacity: vehiclePaperBloc.vehiclePaperModel.engineCapacity,
//                      transactionDate: vehiclePaperBloc.vehiclePaperModel.transactionDate,
//                      expiryDate: vehiclePaperBloc.vehiclePaperModel.expiryDate,
//                      dateIssued: vehiclePaperBloc.vehiclePaperModel.dateIssued,
//                      roadWorthiness: vehiclePaperBloc.vehiclePaperModel.roadWorthiness,
//                      roadWorthinessType: vehiclePaperBloc.vehiclePaperModel.roadWorthinessType,
//                      insuranceRenewal: vehiclePaperBloc.vehiclePaperModel.insuranceRenewal,
//                      insuranceRenewalType: vehiclePaperBloc.vehiclePaperModel.insuranceRenewalType,
//                      requestTime: vehiclePaperBloc.vehiclePaperModel.requestTime,
//                      requestDate: vehiclePaperBloc.vehiclePaperModel.requestDate,
//                      vehicleId: vehiclePaperBloc.vehiclePaperModel.registrationNumber + vehiclePaperBloc.vehiclePaperModel.requestTime,
//                    )
//                );
                    setState(() {
                      _saving = false;
                    });
                    if (payStackBloc.status == PaymentState.Successful) {
                      showDialog(
                          context: context,
                          builder: (context){
                            // Future.delayed(Duration(seconds: 2), () {
                            //   Navigator.of(context).pop();
                            // });
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
    );
  }
}

class BuildCostSummary extends StatelessWidget {
  final String title;
  final String cost;
  BuildCostSummary({this.title, this.cost});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title ?? '', 
          style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontStyle: FontStyle.normal, fontSize: 16),
          ),
          Text(
          cost ?? '', 
          style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontStyle: FontStyle.normal, fontSize: 16),
          ),
      ],
    );
  }
}