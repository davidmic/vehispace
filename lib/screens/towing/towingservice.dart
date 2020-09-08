import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/towingbloc.dart';
import 'package:vehispace/screens/towing/towingchose.dart';
import 'package:vehispace/screens/towing/towinginfo.dart';
import 'package:vehispace/screens/towing/towinginfoexistingvehicle.dart';
import 'package:vehispace/screens/towing/towinginfomap.dart';
import 'package:vehispace/screens/towing/towingoderpayment.dart';
import 'package:vehispace/screens/towing/towingorderrequest.dart';


enum Towing {Choose, Order, Request, Payment, Information, ExistingVehicleOrder}

class TowingService extends StatefulWidget {
  static int itemIndex;
  @override
  _TowingServiceState createState() => _TowingServiceState();
}

class _TowingServiceState extends State<TowingService> {
//  Completer<GoogleMapController> _controller = Completer();

  Towing page = Towing.Choose;
  bool existingVehicle = false;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appTitle = Provider.of<AppBarTitle>(context);
    var towingBloc = Provider.of<TowingBloc>(context);
    Widget myPage;
if (page == Towing.Order) {
  myPage = TowingInformation(
    onBack: (){
      setState(() {
        page = Towing.Choose;
      });
    },
    onPressed: (){
      setState(() {
        page = Towing.Request;
      });
       appTitle.changeTitle(
          pageTitle: 'Towing Order',
        );
    },
  );
} else if (page == Towing.Request) {
    myPage = TowingOrderRequest(
      editOnPressed: (){
        setState(() {
          existingVehicle ? page = Towing.ExistingVehicleOrder : page = Towing.Order;
        });
      },
      onPressed: (){
        setState(() {
          page = Towing.Payment;
        });
        appTitle.changeTitle(
          pageTitle: 'Payment Options',
        );
      },
    );
} else if (page == Towing.Payment) {
    myPage = TowingOrderPayment(
      editOnPressed: (){
        setState(() {
          existingVehicle ? page = Towing.ExistingVehicleOrder : page = Towing.Order;
        });
      },
      onPressed: (){
//        Navigator.push(context, MaterialPageRoute(builder: (context) => TowingInformationMap()));
        setState(() {
          page = Towing.Information;
        });
        appTitle.changeTitle(
          pageTitle: 'Towing Information',
        );
      },
    );
} 
else if (page == Towing.Information) {
  myPage = TowingInformationMap(
    // editOnPressed: (){
    //     setState(() {
    //       page = Towing.Order;
        //   appTitle.changeTitle(
        //   pageTitle: 'Towing Information',
        // );
      //   });
      // },
    // latitude: towingBloc.towingDetails.latitude,
    // longitude: towingBloc.towingDetails.longitude,
  );
}
 else if (page == Towing.Choose) {
   myPage = ChooseVehicle(
     onPressed: (){
       setState(() {
         page = Towing.Order;
       });
       appTitle.changeTitle(
         pageTitle: 'Towing Information',
       );
     },
     existingVehicleOnpressed: (){
       setState(() {
         page = Towing.ExistingVehicleOrder;
         existingVehicle = true;
       });
     },
   );
}
 else if (page == Towing.ExistingVehicleOrder) {
   myPage = TowingInformationExistingVehicle(
     onBack: (){
      setState(() {
        page = Towing.Choose;
      });
    },
     index: TowingService.itemIndex,
     onPressed: (){
       setState(() {
         page = Towing.Request;
       });
       appTitle.changeTitle(
         pageTitle: 'Towing Order',
       );
     },
   );
}
    return myPage;
  }
}
