import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/screens/towinginfo.dart';
import 'package:vehispace/screens/towinginfomap.dart';
import 'package:vehispace/screens/towingoderpayment.dart';
import 'package:vehispace/screens/towingorderrequest.dart';
import 'package:vehispace/screens/vehicleorderrequest.dart';
import 'package:vehispace/screens/vehiclepaperdashboard.dart';
import 'package:vehispace/screens/vehiclepapers.dart';
import 'package:vehispace/screens/vehiclepaperspayment.dart';
import 'package:vehispace/provider/appbartitle.dart';


enum VehiclePaper {Order, Request, Payment, Information}

class VehiclePaperService extends StatefulWidget {
  @override
  _VehiclePaperServiceState createState() => _VehiclePaperServiceState();
}

class _VehiclePaperServiceState extends State<VehiclePaperService> {
//  Completer<GoogleMapController> _controller = Completer();

  VehiclePaper page = VehiclePaper.Order;

  // GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appTitle = Provider.of<AppBarTitle>(context);
    Widget myPage;
if (page == VehiclePaper.Order) {
  myPage = VehiclePapers(
    onPressed: (){
      setState(() {
        page = VehiclePaper.Request;
      });
      appTitle.changeTitle(
          pageTitle: 'Vehicle Papers',
        );
    },
  );
} else if (page == VehiclePaper.Request) {
    myPage = VehiclePapersRequest(
      editOnPressed: (){
        setState(() {
          page = VehiclePaper.Order;
        });
      },
      onPressed: (){
        setState(() {
          page = VehiclePaper.Payment;
        });
         appTitle.changeTitle(
          pageTitle: 'Payment Options',
        );
      },
    );
} else if (page == VehiclePaper.Payment) {
    myPage = VehiclePapersPayment(
      editOnPressed: (){
        setState(() {
          page = VehiclePaper.Order;
        });
      },
      onPressed: (){
        setState(() {
          page = VehiclePaper.Information;
        });
         appTitle.changeTitle(
          pageTitle: 'Vehicle Papers',
        );
      },
    );
} 
else if (page == VehiclePaper.Information) {
  myPage = VehiclePapersDashboard();
}  
    return myPage;
  }
}
