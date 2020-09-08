import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/vehiclepapersbloc.dart';
import 'package:vehispace/screens/towing/towinginfomap.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:vehispace/widgets/towingrequestcard.dart';
import 'package:vehispace/widgets/vehiclepaperscard.dart';

class VehiclePapersDashboard extends StatefulWidget {
  final Function onPressed;
  VehiclePapersDashboard({this.onPressed});
  @override
  _VehiclePapersDashboardState createState() => _VehiclePapersDashboardState();
}

class _VehiclePapersDashboardState extends State<VehiclePapersDashboard> {
  @override
  Widget build(BuildContext context) {
    var vehiclePaperBloc = Provider.of<VehiclePaperBloc>(context);
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Stack(
    // fit: StackFit.expand,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.26),
    //     child: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: 1,
    //     itemBuilder: (context, index) {
    //       return VehiclePaperRequestCard();
    //     }
    //  ),
      //  child: Column(
      //     children: <Widget>[
           
            
      //     ],
      //   )
      ),
      Center(child: Image.asset('assets/images/Asset3.png')),
        ],
       ),
        VehiclePaperRequestCard(
          vehicleMake: vehiclePaperBloc.vehiclePaperModel.vehicleMake,
          registrationNumber: vehiclePaperBloc.vehiclePaperModel.registrationNumber,
          engineNumber: vehiclePaperBloc.vehiclePaperModel.engineNumber,
          engineCapacity: vehiclePaperBloc.vehiclePaperModel.engineCapacity,
          roadWorthiness: vehiclePaperBloc.vehiclePaperModel.roadWorthiness,
          insuranceRenewal: vehiclePaperBloc.vehiclePaperModel.insuranceRenewalType,
          dateTime: vehiclePaperBloc.vehiclePaperModel.requestDate,
        ),
            OtherVehiclePaperRequestCard(
              title: 'Vehicle License',
            ),
            OtherVehiclePaperRequestCard(
              title: 'Road Worthiness',
            ),
            OtherVehiclePaperRequestCard(
              title: 'Insurance',
            ),
      SizedBox(height:50),
      ],
    );
  }
}

