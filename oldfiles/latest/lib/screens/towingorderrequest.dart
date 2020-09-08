import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/towingmodel.dart';
import 'package:vehispace/provider/towingbloc.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/towingrequestcard.dart';
import 'package:vehispace/provider/appbartitle.dart';

class TowingOrderRequest extends StatefulWidget {
  final Function onPressed;
  final Function editOnPressed;
  TowingOrderRequest({this.onPressed, this.editOnPressed});
  @override
  _TowingOrderRequestState createState() => _TowingOrderRequestState();
}

class _TowingOrderRequestState extends State<TowingOrderRequest> {
  @override

  void initState() {
    super.initState();
   
  }
  @override

  Widget build(BuildContext context) {
    var towingBloc = Provider.of<TowingBloc>(context);
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
                isExpanded: true,
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
              child: CustomRaisedButton(
              onPressed: (){
                widget.onPressed();
              },
              text: 'PROCEED TO PAYMENT',
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
}