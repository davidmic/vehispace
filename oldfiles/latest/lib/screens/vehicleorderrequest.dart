import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/vehiclepapers.dart';
import 'package:vehispace/provider/vehiclepapersbloc.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/vehiclepaperscard.dart';

class VehiclePapersRequest extends StatefulWidget {
  final Function onPressed;
  final Function editOnPressed;
  VehiclePapersRequest({this.onPressed, this.editOnPressed});
  @override
  _VehiclePapersRequestState createState() => _VehiclePapersRequestState();
}

class _VehiclePapersRequestState extends State<VehiclePapersRequest> {
  @override


  Widget build(BuildContext context) {
    var vehiclePaperBloc = Provider.of<VehiclePaperBloc>(context);
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
                insuranceRenewal: vehiclePaperBloc.vehiclePaperModel.insuranceRenewal,
                dateTime: vehiclePaperBloc.vehiclePaperModel.requestDate,
                isExpanded: true,
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
              child: CustomRaisedButton(
              onPressed: () async {

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