import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/vehiclepapersbloc.dart';
import 'package:vehispace/widgets/vehiclepaperscard.dart';
import 'package:intl/intl.dart';

class VehiclePapersDashboardBeforeRequest extends StatefulWidget {
  final Function roadWorthinessPressed;
  final Function insurancePressed;
  final Function licensePressed;
  VehiclePapersDashboardBeforeRequest({this.insurancePressed, this.roadWorthinessPressed, this.licensePressed});
  @override
  _VehiclePapersDashboardBeforeRequestState createState() => _VehiclePapersDashboardBeforeRequestState();
}

class _VehiclePapersDashboardBeforeRequestState extends State<VehiclePapersDashboardBeforeRequest> {
  final format = DateFormat('dd/MM/yy');
  @override
  void initState () {
    super.initState();
    AppBarTitle().appBarTitle = 'Vehicle Papers';
    VehiclePaperBloc().getPriceList();
  }

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
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
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
//        VehiclePaperRequestCard(
//          vehicleMake: vehiclePaperBloc.vehiclePaperModel.vehicleMake,
//          registrationNumber: vehiclePaperBloc.vehiclePaperModel.registrationNumber,
//          engineNumber: vehiclePaperBloc.vehiclePaperModel.engineNumber,
//          engineCapacity: vehiclePaperBloc.vehiclePaperModel.engineCapacity,
//          roadWorthiness: vehiclePaperBloc.vehiclePaperModel.roadWorthiness,
//          insuranceRenewal: vehiclePaperBloc.vehiclePaperModel.insuranceRenewalType,
//          dateTime: vehiclePaperBloc.vehiclePaperModel.requestDate,
//        ),
        OtherVehiclePaperRequestCard(
          title: 'Vehicle License',
          dateTime: format.format(DateTime.now()),
          onPressed:
            widget.licensePressed,
        ),
        OtherVehiclePaperRequestCard(
          title: 'Road Worthiness',
          dateTime: format.format(DateTime.now()),
          onPressed:
            widget.roadWorthinessPressed,

        ),
        OtherVehiclePaperRequestCard(
          title: 'Insurance',
          dateTime: format.format(DateTime.now()),
          onPressed:
            widget.insurancePressed,

        ),
        SizedBox(height:50),
      ],
    );
  }
}

