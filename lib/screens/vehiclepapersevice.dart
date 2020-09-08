import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/screens/towinginfo.dart';
import 'package:vehispace/screens/towinginfomap.dart';
import 'package:vehispace/screens/towingoderpayment.dart';
import 'package:vehispace/screens/towingorderrequest.dart';
import 'package:vehispace/screens/vehicleorderrequest.dart';
import 'package:vehispace/screens/vehiclepaperdashboardafterrequest.dart';
import 'package:vehispace/screens/vehiclepaperdashboardbeforerequest.dart';
import 'package:vehispace/screens/vehiclepapers.dart';
import 'package:vehispace/screens/vehiclepapersinsuranceandlicense.dart';
import 'package:vehispace/screens/vehiclepaperspayment.dart';
import 'package:vehispace/provider/appbartitle.dart';


enum VehiclePaper {Dashboard, Order, OrderInsuranceAndLicense, Request, Payment, Information}

class VehiclePaperService extends StatefulWidget {
  @override
  _VehiclePaperServiceState createState() => _VehiclePaperServiceState();
}

class _VehiclePaperServiceState extends State<VehiclePaperService> {
//  Completer<GoogleMapController> _controller = Completer();

  VehiclePaper page = VehiclePaper.Dashboard;

  // GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appTitle = Provider.of<AppBarTitle>(context);
    Widget myPage;
 if (page == VehiclePaper.Dashboard){
       myPage = VehiclePapersDashboardBeforeRequest(
         licensePressed: (){
           print('pressed');
           setState(() {
             page = VehiclePaper.Order;
           });
         },
         roadWorthinessPressed: (){
           setState(() {
             page = VehiclePaper.OrderInsuranceAndLicense;
           });
         },
         insurancePressed: (){
           setState(() {
             page = VehiclePaper.OrderInsuranceAndLicense;
           });
         },
       );
 }
 else if (page == VehiclePaper.Order) {
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

}
 else if (page == VehiclePaper.OrderInsuranceAndLicense) {
   myPage = VehiclePapersInsuranceAndLicense(
     onPressed: (){
       setState(() {
         page = VehiclePaper.Request;
       });
       appTitle.changeTitle(
         pageTitle: 'Vehicle Papers',
       );
     },
   );

 }
 else if (page == VehiclePaper.Request) {
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
  myPage = VehiclePapersDashboardAfterRequest();
}  
    return myPage;
  }
}
