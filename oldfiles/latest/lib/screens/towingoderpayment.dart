import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/towingmodel.dart';
import 'package:vehispace/provider/towingbloc.dart';
import 'package:vehispace/screens/towinginfomap.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:vehispace/widgets/towingrequestcard.dart';
import 'package:vehispace/provider/appbartitle.dart';

class TowingOrderPayment extends StatefulWidget {
  final Function onPressed;
  final Function editOnPressed;
  TowingOrderPayment({this.onPressed, this.editOnPressed});
  @override
  _TowingOrderPaymentState createState() => _TowingOrderPaymentState();
}

class _TowingOrderPaymentState extends State<TowingOrderPayment> {
  bool _saving = false;
  @override

 void initState() {
    super.initState();
    AppBarTitle().appBarTitle = 'Payment Options';
  }
  @override

  Widget build(BuildContext context) {
    var towingBloc = Provider.of<TowingBloc>(context);
    return ModalProgressHUD(
       inAsyncCall: _saving,
        dismissible: false,
        progressIndicator: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10,),
                Text('Processing Payment ...', style: TextStyle(fontFamily: 'Sansation'),),
              ]
          ),
        ),
          child: ListView(
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
                     'N6000',
                     style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontFamily: 'Sansation', fontStyle: FontStyle.normal, fontSize: 16),
                     ),
                 ],
               ),
         ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  suffixIcon: Image.asset('assets/images/cardtypea.png'),
                  hint: "No Card",
                  readOnly: true,
                  labelText: 'Pay with Card',
                  onSaved: (val) {
//            lastName = val;
                  },
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
        SizedBox(
              width: MediaQuery.of(context).size.width * 0.93,
                child: CustomRaisedButton(
                onPressed: () async {
                  print('i was tapped');
//              setState(() {
//                _saving = true;
//              });
                  // Future.delayed(Duration(seconds: 5));
                  await towingBloc.storeTowingRequest(
                    towingModel: TowingModel(
                      country: towingBloc.towingDetails.country,
                      state: towingBloc.towingDetails.state,
                      lga: towingBloc.towingDetails.lga,
                      vehicle: towingBloc.towingDetails.vehicle,
                      brand: towingBloc.towingDetails.brand,
                      model: towingBloc.towingDetails.model,
                      location: towingBloc.towingDetails.location,
//                      latitude: towingBloc.towingDetails.latitude,
//                      longitude: towingBloc.towingDetails.longitude,
                      destination: towingBloc.towingDetails.destination,
//                      destLatitude: towingBloc.towingDetails.destLatitude,
//                      destLongitude: towingBloc.towingDetails.destLongitude,
                      conditionOfVehicle: towingBloc.towingDetails.conditionOfVehicle,
                      casualty: towingBloc.towingDetails.casualty,
                      additionalInfo: towingBloc.towingDetails.additionalInfo ?? '',
                      requestTime: towingBloc.towingDetails.requestTime,
                      requestDate: towingBloc.towingDetails.requestDate,
                    )
                  );
                  print('i was tapped again');
                  setState(() {
                    _saving = false;
                  });
                  if (towingBloc.request == Request.sent) {
                    showDialog(
                      context: context,
                      builder: (context){
                        // Future.delayed(Duration(seconds: 2), () {
                        //   Navigator.of(context).pop();
                        // });
                        return PaymentSuccessful();
                      }
                    );
                    print('i was tapped again again');
                    widget.onPressed();
                    print('i was tapped');
                  }
                  else if (towingBloc.request == Request.notSent) {
                    print('i was tapped i failed');

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
          ),
    );
  }
}