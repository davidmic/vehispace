import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/screens/papers/vehiclepaperchose.dart';
import 'package:vehispace/screens/papers/vehicleorderrequest.dart';
import 'package:vehispace/screens/papers/vehiclepaperdashboardafterrequest.dart';
import 'package:vehispace/screens/papers/vehiclepaperdashboardbeforerequest.dart';
import 'package:vehispace/screens/papers/vehiclepaperinsuranceandlicenseexisting.dart';
import 'package:vehispace/screens/papers/vehiclepapers.dart';
import 'package:vehispace/screens/papers/vehiclepapersexisting.dart';
import 'package:vehispace/screens/papers/vehiclepapersinsuranceandlicense.dart';
import 'package:vehispace/screens/papers/vehiclepaperspayment.dart';
import 'package:vehispace/provider/appbartitle.dart';


enum VehiclePaper {Dashboard, Order, OrderInsuranceAndLicense, Request, Payment, Information, ChoseVehicle}

class VehiclePaperService extends StatefulWidget {
  static int itemIndex;

  @override
  _VehiclePaperServiceState createState() => _VehiclePaperServiceState();
}

class _VehiclePaperServiceState extends State<VehiclePaperService> {
//  Completer<GoogleMapController> _controller = Completer();

  VehiclePaper page = VehiclePaper.Dashboard;
  bool vehicleLicense = false;
  bool isExisting = false;

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
             page = VehiclePaper.ChoseVehicle;
             vehicleLicense = true;
           });
         },
         roadWorthinessPressed: (){
           setState(() {
             page = VehiclePaper.ChoseVehicle;
             vehicleLicense = false;
           });
         },
         insurancePressed: (){
           setState(() {
             page = VehiclePaper.ChoseVehicle;
             vehicleLicense = false;
           });
         },
       );
 }
 else if (page == VehiclePaper.Order) {
      myPage = vehicleLicense ?
        isExisting ?
        VehiclePapersExisting(
          index: VehiclePaperService.itemIndex,
          onBack:  (){
            setState(() {
              page = VehiclePaper.Dashboard;
            });
          },
          onPressed: (){
            setState(() {
              page = VehiclePaper.Request;
            });
            appTitle.changeTitle(
              pageTitle: 'Vehicle Papers',
            );
          },
        ) :
        VehiclePapers(
          onBack:  (){
            setState(() {
              page = VehiclePaper.Dashboard;
            });
          },
        onPressed: (){
          setState(() {
            page = VehiclePaper.Request;
          });
          appTitle.changeTitle(
              pageTitle: 'Vehicle Papers',
          );
        },
      ) : isExisting ?
      VehiclePapersInsuranceAndLicenseExisting(
        index: VehiclePaperService.itemIndex,
        onBack:  (){
          setState(() {
            page = VehiclePaper.Dashboard;
          });
        },
        onPressed: (){
          setState(() {
            page = VehiclePaper.Request;
          });
          appTitle.changeTitle(
            pageTitle: 'Vehicle Papers',
          );
        },
      ) :
      VehiclePapersInsuranceAndLicense(
        onBack:  (){
          setState(() {
            page = VehiclePaper.Dashboard;
          });
        },
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
  myPage = VehiclePapersDashboardAfterRequest(
    licensePressed: (){
      print('pressed');
      setState(() {
        page = VehiclePaper.ChoseVehicle;
        vehicleLicense = true;
      });
    },
    roadWorthinessPressed: (){
      setState(() {
        page = VehiclePaper.ChoseVehicle;
        vehicleLicense = false;
      });
    },
    insurancePressed: (){
      setState(() {
        page = VehiclePaper.ChoseVehicle;
        vehicleLicense = false;
      });
    },
  );
}
 else if (page == VehiclePaper.ChoseVehicle) {
   myPage = ChooseVehiclePapers(
     onPressed: (){
       setState(() {
         page = VehiclePaper.Order;
       });
       appTitle.changeTitle(
         pageTitle: 'Vehicle Papers',
       );
     },
     existingVehicleOnpressed: (){
       setState(() {
         isExisting = true;
         page = VehiclePaper.Order;
//         existingVehicle = true;
       });
     },
   );
 }
    return myPage;
  }
}
